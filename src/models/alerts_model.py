"""module contains Alerts model"""
from sqlalchemy import Column, ForeignKey, String, Integer
from sqlalchemy.orm import relationship
from config.db_config import Base
from schemas import constants
from enum import Enum


class Status(str, Enum):
    """enum for alert status"""
    open = 'open'
    close = 'close'
    
class Alerts(Base):
    """Alerts Table"""
    __tablename__ = constants.alerts
    alert_id = Column(Integer, primary_key=True)
    condition = Column(String(255), nullable=False)
    setpoint = Column(String(30), nullable=False)
    timeframe = Column(String(12), nullable=False)
    alert_medium = Column(String(30), nullable=False)
    repeat_setpoint = Column(Integer, default=1)
    alert_count = Column(Integer, default = 0)
    status = Column(String(30), default=Status.open)
    user_id = Column(Integer, ForeignKey(constants.user_foriegn_key))

    owner = relationship(constants.User, back_populates=constants.user_alerts_column)
