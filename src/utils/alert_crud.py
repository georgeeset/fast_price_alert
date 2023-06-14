"""Crud activities on Alert table"""

import time
from models import alerts_model, user_model
from sqlalchemy.orm import session
from schemas import constants
from schemas.alerts import AlertEditIn, AlertIn


def create_new_alert(alert: AlertIn, user_id: int, db: session):
    """create new alert signal"""
    new_alert = alerts_model.Alerts(**alert.dict())
    new_alert.user_id = user_id
    new_alert.time_created = time.time()  # epoch seconds
    new_alert.status = alerts_model.AlertStatus.open
    db.add(new_alert)
    db.commit()
    db.refresh(new_alert)
    return (new_alert)

def get_alert_by_id(alert_id: int, user_id: int, db: session)->alerts_model.Alerts:
    """query alerts with given alert id and user id return 1 alert"""
    return db.query(
        alerts_model.Alerts
    ).filter(
        alerts_model.Alerts.alert_id == alert_id
        and
        alerts_model.Alerts.user_id == user_id
    ).first()

def update_alert(alert: AlertEditIn, db: session):
    """Edit alert"""
    db.query(
        alerts_model.Alerts
    ).filter(
        alerts_model.Alerts.alert_id == alert.alert_id
    ).update(
        {constants.commodity : alert.commodity,
         constants.condition : alert.condition,
         constants.setpoint : alert.setpoint,
         constants.timeframe : alert.timeframe,
         constants.alert_medium : alert.alert_medium,
         constants.repeat_setpoint: alert.repeat_setpoint,
         constants.expiration : alert.expiration,
         constants.note : alert.note,
         }
    )
    db.commit()

def delete_alert(alert_id: int, user_id: int, db: session):
   i = db.query(
        alerts_model.Alerts
    ).filter(
        alerts_model.Alerts.alert_id == alert_id
        and
        alerts_model.Alerts.user_id == user_id
    ).first()
   if not i:
       return False
   db.delete(i)
   db.commit()
   return True

def get_all_alerts(user_id: int, db = session):
    return db.query(alerts_model.Alerts).filter(
        alerts_model.Alerts.user_id == user_id
        ).order_by(
        alerts_model.Alerts.time_created.asc()
        ).all()
