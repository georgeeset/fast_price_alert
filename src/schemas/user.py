"""schema for user"""
from pydantic import BaseConfig, BaseModel, EmailStr

class BaseUser(BaseModel):
    """General data needed for user"""
    first_name: str
    last_name: str
    username: str
    interests: str
    

class UserIn(BaseUser):
    """input data expected form request
        plus BaseUser data
    """
    password: str

    #set the attribute orm_mode = True
    class Config(BaseConfig):
        orm_mode = True
       

class FullUser(BaseUser):
    """Contain full user table for authorized user"""
    # all relational information for users will be accessed here
    user_id: int
    date_registered: int

    class Config(BaseConfig):
        orm_mode = True

class UserOut(BaseModel):
    """data to confirm success plus BaseUser data"""
    user_id: int 

    #set the attribute orm_mode = True
    class Config(BaseConfig):
        orm_mode = True
       
class UpdateInterest(BaseModel):
    """update list of intesests"""
    interests: str
