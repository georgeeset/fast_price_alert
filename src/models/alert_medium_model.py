"""Module for alarm medium specification"""

from sqlalchemy import Column, ForeignKey, String, Integer
from schemas import constants
from sqlalchemy.orm import relationship
from config.db_config import Base


class AlertMedium(Base):
    """alarm medium table properties"""

    __tablename__ = constants.alert_medium
    alarm_medium_id = Column(Integer, primary_key=True)
    whatsapp_verified = Column(String(20), unique=True, nullable=True)
    email_verified = Column(String(120), unique=True, nullable=True)
    telegram_verified = Column(String(20), unique=True, nullable=True)
    user_id = Column(Integer, ForeignKey(constants.user_foriegn_key))

    owner = relationship(constants.User, back_populates=constants.user_alert_medium_column)
