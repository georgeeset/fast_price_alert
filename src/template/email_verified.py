"""
html template for email verification success
"""

success_page = """<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width">
  <title>Email Verification</title>
  <style>
    body {
      font-family: sans-serif;
      margin: 0;
      padding: 0;
    }
    
    .container {
      width: 500px;
      margin: 0 auto;
    }
    
    h1 {
      text-align: center;
      font-size: 24px;
      margin-bottom: 16px;
    }
    
    p {
      margin-bottom: 16px;
    }
    
    .button {
      background-color: #337ab7;
      color: white;
      font-size: 16px;
      padding: 12px 24px;
      border-radius: 4px;
      cursor: pointer;
    }
    
    .button:hover {
      background-color: #2e6da4;
    }
  </style>
</head>
<body>
  <div class="container">
    <h1>Your email has been verified!</h1>
    <p>You can now log in to your account and set Alerts.</p>
    <a href="/login" class="button">Log in</a>
  </div>
</body>
</html>
"""