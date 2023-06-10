"""module contains Alerts model"""
import time
from sqlalchemy import Column, Float, ForeignKey, String, Integer
from sqlalchemy.orm import relationship
from config.db_config import Base
from schemas import constants
from enum import Enum


class AlertStatus(str, Enum):
    """enum for alert status"""
    open = 'open'
    close = 'close'
    
class Alerts(Base):
    """Alerts Table"""
    __tablename__ = constants.alerts
    alert_id = Column(Integer, primary_key=True)
    commodity = Column(String(10), nullable=False)
    condition = Column(String(255), nullable=False)
    setpoint = Column(Float, nullable=False)
    timeframe = Column(String(12), nullable=False)
    alert_medium = Column(String(30), nullable=False)
    repeat_setpoint = Column(Integer, default=1)
    alert_count = Column(Integer, default = 0)
    status = Column(String(30), default=AlertStatus.open)
    user_id = Column(Integer, ForeignKey(constants.user_foriegn_key))
    time_created = Column(Float, nullable=False)
    # time must be converted to hours
    expiration = Column(Integer, nullable=False)

    owner = relationship(constants.User, back_populates=constants.user_alerts_column)

    # def is_expired(self)->bool:
    #     """Instance method to detect if alsert has expired or not"""
    #     now = time.time() # time in seconds since epoch
    #     # convert expiration to seconds
    #     expiry = self.time_created + (self.expiration * 60 * 60)
    #     if now > expiry:
    #         return True
    #     return False
