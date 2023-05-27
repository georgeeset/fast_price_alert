"""schema for user"""
from pydantic import BaseModel, EmailStr

class BaseUser(BaseModel):
    """General data needed for user"""

    first_name: str
    last_name: str
    mobile_number: str
    email: EmailStr
    date_registered: int
    interests: str

class UserIn(BaseUser):
    """input data expected form request
        plus BaseUser data
    """
    password: str

class UserOut(BaseUser ):
    """data to confirm success plus BaseUser data"""
    user_id: int 

    #set the attribute orm_mode = True
    class config:
        orm_mode = True
        allow_population_by_field_name = True
        arbitrary_types_allowed = True
