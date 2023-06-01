""" CRUD activity for alert medium of registered users"""
from sqlalchemy.orm import session

from models import alert_medium_model


def check_email(email:str, db:session)->bool:
    """check if email exist before attempting to save it
    Returns True if already
    """
    q_result = db.query(
        alert_medium_model.AlertMedium
        ).filter(
        alert_medium_model.AlertMedium.email_verified == email
        ).first()

    if q_result:
        return True
    return False

def add_email(email: str, user_id:int, db:session):
    """ Add email to verified alert medium for the specific user"""
    pass
