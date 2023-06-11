"""Register and manage alert medium for users"""

from pydantic import BaseModel, EmailStr


class VerifyEmailIn(BaseModel):
    email: EmailStr


class EmailSentOut(VerifyEmailIn):
    message: str

class AlertMediumOut(BaseModel):
    """Alert Medium Format"""
    alert: str
    address: str