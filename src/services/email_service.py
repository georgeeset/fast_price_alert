"""Send email to alert users"""

import os
from email.message import EmailMessage
import ssl
import smtplib

email_sender = os.environ.get('EMAIL')
email_password = os.environ.get('EMAIL_PASS')
email_port = os.environ.get('EMAIL_PORT')


def send_mail(email_receiver: str, subject: str, body: str):
    """cratre instance and send email"""

    em = EmailMessage()
    em['From'] = email_sender
    em['To'] = email_receiver
    em['subject'] = subject
    em.set_content(body)

    context = ssl.create_default_context()
    with smtplib.SMTP_SSL('smtp.gmail.com', email_port, context=context) as smtp:
        smtp.login(email_sender, email_password)
        smtp.sendmail(email_sender, email_receiver, em.as_string())
