"""module contains data structure for user"""
import bcrypt
from sqlalchemy import ARRAY, Column, Float, String, Integer
from schemas import constants
from config.db_config import Base
from sqlalchemy.orm import relationship


class User(Base):
    """User model containing basic user data"""

    __tablename__ = constants.user
    user_id = Column(Integer, primary_key=True, nullable=False)
    first_name = Column(String(30), nullable=False)
    last_name = Column(String(30), nullable=False)
    username = Column(String(120), unique=True, nullable=False)
    date_registered = Column(Float, nullable=False)
    interests = Column(String(255), nullable=True)
    password = Column(String(255))
    
    user_alerts = relationship(constants.Alerts, back_populates=constants.owner)
    user_alert_medium = relationship(constants.AlertMedium, back_populates=constants.owner)

    def verify_password(self, password):
        return bcrypt.checkpw(password, self.password)
    
    def __repr__(self):
        return {constants.user_id: self.user_id, constants.first_name: self.first_name,
                constants.username: self.username, constants.date_registered: self.date_registered,
                constants.interests: self.interests}
