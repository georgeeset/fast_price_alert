"""Crud activities on Alert table"""

import time
from models import alerts_model
from sqlalchemy.orm import session
from schemas.alerts import AlertIn


def create_new_alert(alert: AlertIn, user_id: int, db: session):
    new_alert = alerts_model.Alerts(**alert.dict())
    new_alert.user_id = user_id
    new_alert.time_created = time.time() # epoch seconds
    db.add(new_alert)
    db.commit()
    db.refresh(new_alert)
    return (new_alert)