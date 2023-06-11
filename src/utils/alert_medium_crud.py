""" CRUD activity for alert medium of registered users"""
from sqlalchemy.orm import session

from models import alert_medium_model, user_model
from schemas import constants


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


def alert_medium_exists(user_id:int, db:session)->int:
    """check table with user_id if alert medium has already been created
    return alert_medium_id if exist or None if not
    """
    checker = db.query(
        alert_medium_model.AlertMedium
    ).filter(
        alert_medium_model.AlertMedium.user_id == user_id
    ).first()

    if checker:
        return checker.alert_medium_id
    return None


def add_email_alert_medium(email:str, first_name:str, user_id:int, db:session)->bool:
    """ Add email to verified alert medium for the specific user"""
    #first confirm if the user exist in alert_medium table
    checker = db.query(
        user_model.User
    ).filter(
        user_model.User.user_id == user_id
        and
        user_model.User.first_name == first_name
    ).first()

    if not checker:
        return False
    
    target_id = alert_medium_exists(db=db, user_id=user_id)
    if target_id:
        db.query(
            alert_medium_model.AlertMedium
        ).filter(
            alert_medium_model.AlertMedium.alert_medium_id == target_id
        ).update(
                {constants.email_verified: email}
        )

    else:
        new_medium = alert_medium_model.AlertMedium(email_verified = email, user_id=user_id)
        # new_medium.email_verified = email
        # new_medium.user_id = user_id
        db.add(new_medium)

    db.commit()
    return True

def get_user_alert_medium(user_id: int, db:session)->dict:
    """Get all alert medium for user to select during alert creation"""
    result = db.query(
        alert_medium_model.AlertMedium
    ).filter(
        alert_medium_model.AlertMedium.user_id == user_id
    ).first()

    if result:
        return result.get_dict()
    return None
