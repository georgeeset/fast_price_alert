"""Main app baise route"""
from fastapi import FastAPI, status, HTTPException, Depends
from schemas import constants
from schemas.user import UserIn, UserOut
from config.db_config import Base, engine, SessionLocal
from models import user_model
from sqlalchemy.orm import session

Base.metadata.create_all(bind=engine)

app = FastAPI()


# Dependency
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@app.get("/", tags=["root"])
def read_root() -> dict:
    """print data"""
    return {"message": "fast signal"}


@app.post("/add-user", response_model=UserOut, status_code=status.HTTP_201_CREATED, tags=["Add User"])
def create_user(user: UserIn, db: session = Depends(get_db)):
    new_user = user_model.User(**user.dict())
    check_db = db.query(user_model.User).filter(user_model.User.email == user.email or user_model.User.mobile_number == user.mobile_number).first()
    if check_db:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail=constants.user_already_exists)
    raw_password = user.password
    hashed_password = raw_password + "hashed"
    new_user.password = hashed_password
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    # print(new_user.dict())
    return {**user.dict(), "user_id": new_user.user_id}
    # return {**new_user.dict()} #I dont have __dict__ of my class yet so.. to need