"""this module handles crud functions for user table"""

import bcrypt
from models import user_model
from schemas import constants
from schemas.user import UserIn
from sqlalchemy.orm import session
from sqlalchemy import update
import time


def user_exist(username: str, db: session):
    """check if user exist with given username"""
    return db.query(
        user_model.User
    ).filter(
        user_model.User.username == username
    ).first()


def add_user(user: UserIn, db: session):
    """Add new user"""
    new_user = user_model.User(**user.dict())
    new_user.date_registered = time.time() #secs since epoch
    hashed_password = bcrypt.hashpw(
        user.password.encode('utf-8'),
        bcrypt.gensalt())
    new_user.password = hashed_password
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    # return {**user.dict(), "user_id": new_user.user_id}
    return new_user


def confirm_user(username: str, password: str, db: session):
    """Check if user exist and password hash as same
    with the one provieded
    """
    this_user = user_exist(username=username, db=db)
    if not this_user:
        return None
    encoded_pass = password.encode('utf-8')
    correct_pass = bcrypt.checkpw(
        encoded_pass, this_user.password.encode('utf-8'))
    if correct_pass:
        return this_user
    return None


def get_user(user_id: str, db: session)->user_model.User:
    return db.query(
        user_model.User
    ).filter(
        user_model.User.user_id == user_id
    ).first()

def edit_user(db: session, new_data: user_model.User):
    """update user information"""
    #update only interests
    db.query(
        user_model.User
    ).filter(
        user_model.User.user_id == new_data.user_id
    ).update(
        {constants.interests: new_data.interests}
    )
    db.commit()