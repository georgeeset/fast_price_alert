"""Email verificatio html body for email verification procedure"""

def body(email_link):
    return f"""
    Thanks for registering your email with us:


    click here to verify your email address
    {email_link}
    """