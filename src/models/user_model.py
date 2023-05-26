"""module contains data structure for user"""
from sqlalchemy import Column, String, Integer
from schemas import constants
from config.db_config import Base
from sqlalchemy.orm import relationship


class User(Base):
    """User model containing basic user data"""

    __tablename__ = constants.user
    user_id = Column(Integer, primary_key=True, nullable=False)
    first_name = Column(String(30), nullable=False)
    last_name = Column(String(30), nullable=False)
    mobile_number = Column(String(20), unique=True, nullable=False)
    email = Column(String(120), unique=True, nullable=False)
    date_registered = Column(Integer, nullable=False)
    intersts = Column(String(255), nullable=True)
    password = Column(String(255))
    
    user_alerts = relationship(constants.Alerts, back_populates=constants.owner)
    user_alert_medium = relationship(constants.AlertMedium, back_populates=constants.owner)

