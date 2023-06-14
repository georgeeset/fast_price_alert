"""pydentic model for alert transactions"""

from pydantic import BaseModel




class AlertIn(BaseModel):
    """incoming alert data"""
    condition : str
    commodity : str
    setpoint : float
    timeframe : str 
    alert_medium : str
    repeat_setpoint : int
    expiration : int | None = 24
    note: str


class AlertOut(BaseModel):
    """outgoing alert data"""
    alert_id : int

    class Config:
        orm_mode = True


class AlertEditIn(AlertIn):
    """rquired ata for editing alert"""
    alert_id :int


class FullAlert(AlertIn):
    """full outgoing alert"""
    alert_id : int
    alert_count: int
    time_created :int
    user_id : int

    class Config:
        orm_mode = True


class AlertDeleteIn(BaseModel):
    """input data for deleting alert"""
    alert_id : int


class AlertDeleteFB(BaseModel):
    """Feedback for deleted alert"""
    status : str

class SupportedAssets(BaseModel):
    """Conatians data format for supported currencies
    an empty map for now as list of commodities will be listed inside
    """
    commodities: list