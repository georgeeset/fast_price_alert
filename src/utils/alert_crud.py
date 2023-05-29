"""Crud activities on Alert table"""

import time
from models import alerts_model
from sqlalchemy.orm import session
from schemas import constants
from schemas.alerts import AlertEditIn, AlertIn


def create_new_alert(alert: AlertIn, user_id: int, db: session):
    """create new alert signal"""
    new_alert = alerts_model.Alerts(**alert.dict())
    new_alert.user_id = user_id
    new_alert.time_created = time.time()  # epoch seconds
    db.add(new_alert)
    db.commit()
    db.refresh(new_alert)
    return (new_alert)

def get_alert_by_id(alert_id: int, user_id: int, db: session)->alerts_model.Alerts:
    """query alerts with given alert id and user id"""
    return db.query(
        alerts_model.Alerts
    ).filter(
        alerts_model.Alerts.alert_id == alert_id
        and
        alerts_model.Alerts.user_id == user_id
    )

def update_alert(alert: AlertEditIn, db: session):
    """Edit alert"""
    db.query(
        alerts_model.Alerts
    ).filter(
        alerts_model.Alerts.alert_id == alert.alert_id
    ).update(
        {constants.comodity : alert.comodity,
         constants.condition : alert.condition,
         constants.setpoint : alert.setpoint,
         constants.timeframe : alert.timeframe,
         constants.alert_medium : alert.alert_medium,
         constants.repeat_setpoint: alert.repeat_setpoint,
         constants.expiration : alert.expiration,
         }
    )
    db.commit()
