"""module contains data structure for user"""
from sqlalchemy import Column, String, DateTime
from datetime import datetime
from schemas import constants as constant
from sqlalchemy.orm import Mapped
from sqlalchemy.orm import mapped_column
from sqlalchemy.orm import relationship
from models import Base_model


class User_model(Base_model):
    """User model containing basic user data"""
    __tablename__= constant.users
    user_id: Mapped[int] = mapped_column(primary_key=True)
    first_name: Mapped[str] = mapped_column(String(30), nullable=False)
    last_name: Mapped[str] = mapped_column(String(30), nullable=False)
    mobile_number: Mapped[str] = mapped_column(String(20), nullable=False)
    email: Mapped[str] = mapped_column(String(120))
    date_registered: Mapped[datetime] = mapped_column(datetime, nullable=False)
