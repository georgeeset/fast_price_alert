"""Module for alarm medium specification"""

from sqlalchemy import Column, String
from models.base_model import Base
from schemas import constants


class AlarmMedium(Base):
    """alarm medium table properties"""

    __tablename__ = constants.alarm_medium
    alarm_medium_id = Column(int, primary_key=True)
    whatsapp_verified = Column(String, nullable=True)
    email_verified = Column(String, nullable=True)
    telegram_verified = Column(String, nullable=True)

    def __repr__(self) -> str:
        ram = '{%s}({%s}={%d},{%s}={%s}, {%s}={%s}, \
            {%s}={%s})'.format(
                constants.alarm_medium,
                constants.alarm_medium_id, self.alarm_medium_id,
                constants.whatsapp_verified, self.whatsapp_verified,
                constants.email_verified, self.email_verified,
                constants.telegram_verified, self.telegram_verified,
            )
        return ram