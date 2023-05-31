"""token generation and verification"""

import time

import jwt

from schemas import constants


def generate_token(first_name: str, last_name: str, user_id: int, expiry_date: int, email: str)->str:
    """Generate token with given data"""
    token_expiry_date = time.time() + expiry_date
    jwt_secrete = constants.my_jwt_secrete

    token = jwt.encode({constants.first_name: first_name,
                        constants.last_name: last_name,
                        constants.user_id: user_id,
                        constants.exp: token_expiry_date,
                        constants.email: email}, jwt_secrete)
    return token