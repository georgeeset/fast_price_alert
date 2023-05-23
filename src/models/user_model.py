"""module contains data structure for user"""
from sqlalchemy import Column, String
from schemas import constants as constant
from models import Base


class User(Base):
    """User model containing basic user data"""

    __tablename__ = constant.users
    user_id = Column(primary_key=True, nullable=False)
    first_name = Column(String(30), nullable=False)
    last_name = Column(String(30), nullable=False)
    mobile_number = Column(String(20), nullable=False)
    email = Column(String(120))
    date_registered = Column(String, nullable=False)
    intersts = Column(list, nullable=True)

    def __repr__(self):
        ram = '{%s}({%s}={%d},{%s}={%s}, {%s}={%s}, \
            {%s}={%s}, {%s}={%s}, {%s}={%s}, {}={})'.format(
            constant.user_id, self.user_id,
            constant.first_name, self.first_name,
            constant.last_name, self.last_name,
            constant.mobile_number, self.mobile_number,
            constant.email, self.email,
            constant.date_registered, self.date_registered,
            constant.interests, self.interests,
        )
        return ram
