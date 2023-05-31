"""Register and manage alert medium for users"""

from pydantic import BaseModel, EmailStr


class VerifyEmailIn(BaseModel):
    email: EmailStr


class EmailSentOut(VerifyEmailIn):
    message: str

class EmailVerifiedOut(BaseModel):
    message: str


class VerifyTokenIn(BaseException):
    token: str

