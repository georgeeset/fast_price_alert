"""Main app baise route"""

from fastapi import FastAPI, status, HTTPException, Depends
from fastapi.responses import HTMLResponse
from auth.token import generate_token
from models import user_model
from models.alerts_model import AlertStatus
from schemas import constants
from schemas.alert_medium import AlertMediumOut, EmailSentOut, VerifyEmailIn
from schemas.alerts import AlertDeleteFB, AlertDeleteIn, AlertEditIn, AlertIn, AlertOut, FullAlert, SupportedAssets
from schemas.user import FullUser, UpdateInterest, UserIn, UserOut
from config.db_config import Base, engine, SessionLocal
from sqlalchemy.orm import session
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
import jwt
import time
from fastapi.middleware.cors import CORSMiddleware
from services import email_service
from template import email_verification, email_verified
from utils.alert_crud import create_new_alert, delete_alert, get_alert_by_id, get_all_alerts, update_alert
from utils.alert_medium_crud import add_email_alert_medium, check_email, get_user_alert_medium
from utils.user_crud import add_user, confirm_user, edit_user, get_user, user_exist


Base.metadata.create_all(bind=engine)

oauth2_scheme = OAuth2PasswordBearer(tokenUrl='token')
jwt_secrete = constants.my_jwt_secrete

app = FastAPI()

# Dependency

origins = ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
    )

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


def get_current_user(db: session = Depends(get_db), token: str = Depends(oauth2_scheme)):
    try:
        payload = jwt.decode(token, jwt_secrete, algorithms=['HS256'])
    except:
        raise (HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail=constants.invalid_credentials))

    expires = payload.get(constants.exp)
    if time.time() > expires:
        raise (HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail=constants.expired_token,
        ))

    current_user = get_user(
        user_id=payload.get(constants.user_id),
        db=db)

    return FullUser.from_orm(current_user)


# take data from default password request form and generate token
@app.post('/token', tags=["Generate Token"])
def token_gen(db: session = Depends(get_db), form_data: OAuth2PasswordRequestForm = Depends()):
    this_user = confirm_user(username=form_data.username,
                             password=form_data.password, db=db)
    if not this_user:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=constants.invalid_credentials)
    token = generate_token(first_name=this_user.first_name, last_name=this_user.last_name,
                           user_id=this_user.user_id, expiry_date=constants.one_day)
    return {constants.access_token: token, constants.access_type: 'bearer'}


@app.get('/my/account', response_model=FullUser)
def get_user_details(user: FullUser = Depends(get_current_user)):
    return user


@app.get("/", tags=["root"])
def read_root(token: str = Depends(oauth2_scheme)) -> dict:
    return {'the token': token}


@app.post("/add-user", response_model=UserOut, status_code=status.HTTP_201_CREATED, tags=["Add User"])
def create_user(user: UserIn, db: session = Depends(get_db)):
    """confirm user credentials and create user"""
    data = user_exist(username=user.username, db=db)
    if data:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=constants.user_already_exists)

    new_user = add_user(user=user, db=db)
    return {constants.user_id: new_user.user_id}


@app.put("/update/user", response_model=UserOut, status_code=status.HTTP_202_ACCEPTED, tags=["Edit User interests"])
def update_user_interest(interests: UpdateInterest, db: session = Depends(get_db), user: FullUser = Depends(get_current_user)):
    """update user interests"""
    user_update = user_model.User(**user.dict())
    user_update.interests = interests.interests
    edit_user(db=db, new_data=user_update)
    print(user_update.interests)
    return UserOut.from_orm(user_update)


@app.post('/user/create-alert', response_model=AlertOut, status_code=status.HTTP_201_CREATED, tags=["Create Alert"])
def create_alert(alert: AlertIn, user: FullUser = Depends(get_current_user), db: session = Depends(get_db)):
    data = create_new_alert(alert=alert, db=db, user_id=user.user_id)
    if not data:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=constants.invalid_input
        )
    return AlertOut.from_orm(data)


@app.put('/user/edit-alert', response_model=AlertOut, status_code=status.HTTP_202_ACCEPTED, tags=["Update Alert"])
def edit_alert(alert: AlertEditIn, user: FullUser = Depends(get_current_user), db: session = Depends(get_db)):
    """update alert if the alert is not expired and not closed"""
    # check if alert exists
    data = get_alert_by_id(alert_id=alert.alert_id,
                           user_id=user.user_id, db=db,)
    if not data:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=constants.alert_not_found
        )
    print(data.alert_medium)
    now = time.time()  # time in seconds since epoch
    # convert expiration to seconds
    expiry = data.time_created + (data.expiration * 60 * 60)
    if now > expiry:
        raise HTTPException(
            status_code=status.HTTP_406_NOT_ACCEPTABLE,
            detail=constants.alert_has_expired,
        )

    if data.status == AlertStatus.close:
        raise HTTPException(
            status_code=status.HTTP_406_NOT_ACCEPTABLE,
            detail=constants.alert_is_closed,
        )

    update_alert(alert=alert, db=db)
    return alert

@app.delete('/user/delete-alert', response_model=AlertDeleteFB, status_code=status.HTTP_202_ACCEPTED, tags=["Update Alert"])
def alert_delete(alert: AlertDeleteIn, user: FullUser = Depends(get_current_user), db: session = Depends(get_db)):
    data = delete_alert(alert_id=alert.alert_id, user_id=user.user_id, db=db)
    if not data:
        raise HTTPException(
            status_code=status.HTTP_406_NOT_ACCEPTABLE,
            detail=constants.alert_not_found
        )
    return AlertDeleteFB(status=constants.deleted)

@app.get('/user/show-alerts', response_model=list[FullAlert], status_code=status.HTTP_200_OK, tags=["Get All Alerts", "Ordered by Time created"])
def get_alerts(user: FullUser = Depends(get_current_user), db: session = Depends(get_db)):
    """Get all alert ordered by time created"""
    # this_user = user_model.User(**user.dict())
    data = get_all_alerts(user_id=user.user_id, db=db)
    return data

@app.get('/send-email')
def send_email(receiver: str, subject: str, body: str):
    email_service.send_mail(email_receiver=receiver,
                            subject=subject, body=body)
    return {"message": "done"}

@app.post('/update_emal', response_model=EmailSentOut, status_code=status.HTTP_200_OK, tags=["Add email Alert"])
def validate_email(user_email: VerifyEmailIn, user: FullUser = Depends(get_current_user), db: session=Depends(get_db)):
    token = generate_token(last_name=user.last_name,
                           first_name=user.first_name,
                           user_id=user.user_id,
                           email=user_email.email,
                           expiry_date=constants.two_hours,
                           )
    if not token:
        raise HTTPException(
            status_code=status.HTTP_406_NOT_ACCEPTABLE,
            detail=constants.an_error_occured,
        )

    report = check_email(email=user_email.email, db=db)

    if report:
        raise HTTPException(
            status_code=status.HTTP_406_NOT_ACCEPTABLE,
            detail=constants.email_already_exist,
        )

    email_service.send_mail(email_receiver=user_email.email,
                            subject=constants.email_verification,
                            body=email_verification.body(token))

    return EmailSentOut(message=constants.message_sent, email=user_email.email)

@app.get('/confirm-email/{token}', response_class=HTMLResponse, status_code=status.HTTP_200_OK, tags=['Confirm email address'])
def confirm_email(token: str, db: session = Depends(get_db)):
    try:
        payload = jwt.decode(token, jwt_secrete, algorithms=['HS256'])
    except:
        raise (HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail=constants.invalid_credentials))

    expires = payload.get(constants.exp)
    if time.time() > expires:
        raise (HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail=constants.expired_token,
        ))

    db_job = add_email_alert_medium(email=payload.get(constants.email),
                       first_name=payload.get(constants.first_name),
                       db=db, user_id=payload.get(constants.user_id),
                       )

    # TODO add email to alert medium table
    if not db_job:
        raise (HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail=constants.operation_failed_msg))

    return HTMLResponse(content=email_verified.success_page, status_code=200)

@app.get('/get-supported-assets', response_model=SupportedAssets, status_code=status.HTTP_200_OK, tags=["Get List of Supported Assets"])
async def getAssets():
    """Supported assets will be updated as design improves. for now we stick to this list"""
    return SupportedAssets(commodities=constants.supported_assets)

@app.get('/user/show-alert-medium', response_model=list[AlertMediumOut], status_code=status.HTTP_200_OK, tags=['Get All Registered AlertMedium'])
def get_alert_medium(user: FullUser = Depends(get_current_user), db: session = Depends(get_db)):
    """Request for user's registered alert medium"""
    thisMedium = get_user_alert_medium(user_id=user.user_id, db=db)
    composed = []

    if thisMedium:
        for key, value in thisMedium.items():
            if value:
                composed.append(AlertMediumOut(alert=key, address=value))

    return composed
