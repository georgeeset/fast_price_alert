"""Email verificatio html body for email verification procedure"""

def body(email_link):
    return f"""
    Thanks for registering your email with us:


    click here to verify your email address
    http://172.18.27.162:5000/confirm-email/{email_link}
    """