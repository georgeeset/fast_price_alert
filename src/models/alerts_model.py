"""module contains Alerts model"""
from sqlalchemy import Column, String
from models.base_model import Base
from schemas import constants
from enum import Enum


class Status(str, Enum):
    """enum for alert status"""
    open = 'open'
    close = 'close'
    
class Alerts(Base):
    """Alerts Table"""
    __tablename__ = constants.alerts
    alert_id = Column(int, primary_key=True)
    condition = Column(String, nullable=False)
    setpoint = Column(String, nullable=False)
    timeframe = Column(String, nullable=False)
    alert_medium = Column(list, nullable=False)
    repeat_setpoint = Column(int, default=1)
    alert_count = Column(int, default = 0)
    status = Column(Status, default=Status.open)
