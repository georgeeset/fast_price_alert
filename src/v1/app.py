"""Main app baise route"""
import bcrypt
from fastapi import FastAPI, status, HTTPException, Depends
from schemas import constants
from schemas.user import UserIn, UserOut
from config.db_config import Base, engine, SessionLocal
from models import user_model
from sqlalchemy.orm import session
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
import jwt


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

def confirm_user(email: str, password: str, db:session):
    # #check if user eist
    return db.query(user_model.User).filter(user_model.User.email == email).first()

@app.post('/token', tags=["Generate Token"]) #take data from default password request form and generate token 
async def token_gen( db: session = Depends(get_db), form_data: OAuth2PasswordRequestForm=Depends()):
    this_user = confirm_user(email=form_data.username, password=form_data.password, db=db)
    if not this_user:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail='Invalid user credentials')
    token = jwt.encode({constants.first_name: this_user.first_name,
                        constants.last_name: this_user.last_name,
                        constants.user_id: this_user.user_id}, jwt_secrete)
    return {'access_token': token, 'token_type': 'bearer'}

@app.get('/user/me', )
@app.get("/", tags=["root"])
def read_root(token: str=Depends(oauth2_scheme)) -> dict:
    return {'the token': token}

@app.post("/add-user", response_model=UserOut, status_code=status.HTTP_201_CREATED, tags=["Add User"])
def create_user(user: UserIn, db: session = Depends(get_db)):
    new_user = user_model.User(**user.dict())
    check_db = db.query(user_model.User).filter(user_model.User.email == user.email or user_model.User.mobile_number == user.mobile_number).first()
    if check_db:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail=constants.user_already_exists)
    hashed_password = bcrypt.hashpw(user.password.encode('utf-8'), bcrypt.gensalt())
    new_user.password = hashed_password
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    print(new_user.password)
    return {**user.dict(), "user_id": new_user.user_id}
    # return {**new_user.dict()} #I dont have __dict__ of my class yet so.. to need

# @app.get("/get-user", response_model=UserOut, status_code=status.HTTP_200_OK, tags=["Get User Information"])
# def get_user(id: str, payload: ):