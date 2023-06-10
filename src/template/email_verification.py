"""Email verificatio html body for email verification procedure"""

def body(email_link):
    return f"""
    Thanks for registering your email with us:
    You are about to confirm our email as a means of alert for commodity price.



    click here to verify your email address
    http://web-01.esetautomation.tech/fx-market-watch/confirm-email/{email_link}

    If you did not opt for this service. kindly ignore the message.
    """