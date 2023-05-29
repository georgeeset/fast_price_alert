"""Main app baise route"""

from fastapi import FastAPI, status, HTTPException, Depends
from models import user_model
from models.alerts_model import AlertStatus
from schemas import constants
from schemas.alerts import AlertEditIn, AlertIn, AlertOut
from schemas.user import FullUser, UpdateInterest, UserIn, UserOut
from config.db_config import Base, engine, SessionLocal
from sqlalchemy.orm import session
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
import jwt
import time
from utils.alert_crud import create_new_alert, get_alert_by_id
from utils.user_crud import add_user, confirm_user, edit_user, get_user, user_exist


Base.metadata.create_all(bind=engine)

oauth2_scheme = OAuth2PasswordBearer(tokenUrl='token')
jwt_secrete = constants.my_jwt_secrete

app = FastAPI()

# Dependency
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


def get_current_user(db: session = Depends(get_db),token: str = Depends(oauth2_scheme)):
    try:
        payload = jwt.decode(token, jwt_secrete, algorithms=['HS256'])
    except:
        raise (HTTPException(
            status_code= status.HTTP_401_UNAUTHORIZED,
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


@app.post('/token', tags=["Generate Token"]) #take data from default password request form and generate token 
async def token_gen( db: session = Depends(get_db), form_data: OAuth2PasswordRequestForm=Depends()):
    this_user = confirm_user(username=form_data.username, password=form_data.password, db=db)
    if not this_user:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=constants.invalid_credentials)
    token_expiry_date = time.time() + constants.one_day
    token = jwt.encode({constants.first_name: this_user.first_name,
                        constants.last_name: this_user.last_name,
                        constants.user_id: this_user.user_id,
                        constants.exp: token_expiry_date }, jwt_secrete)
    return {constants.access_token: token, constants.access_type: 'bearer'}

@app.get('/my/account', response_model= FullUser)
def get_user_details(user: FullUser = Depends(get_current_user)):
    return user

@app.get("/", tags=["root"])
def read_root(token: str=Depends(oauth2_scheme)) -> dict:
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
def update_user_interest( interests: UpdateInterest, db: session = Depends(get_db), user: FullUser = Depends(get_current_user)):
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

@app.post('/user/edit-alert', response_class=AlertOut, status_code=status.HTTP_202_ACCEPTED, tags=["Update Alert"])
def edit_alert(alert: AlertEditIn, user:FullUser = Depends(get_current_user), db: session = Depends(get_db)):
    """update alert if the alert is not expired and not closed"""
    #check if alert exists
    data = get_alert_by_id(alert_id= alert.alert_id, user_id=user.user_id, db=db,)
    if not data:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=constants.alert_not_found
        )
    if data.expired:
        raise HTTPException(
            status_code=status.HTTP_406_NOT_ACCEPTABLE,
            detail=constants.alert_has_expired,
        )
    
    if data.status == AlertStatus.close:
        raise HTTPException(
            status_code=status.HTTP_406_NOT_ACCEPTABLE,
            detail=constants.alert_is_closed,
        )
    