// store most of the constant strings for the web app

String apiUrl = "http://192.168.4.168:6003";
//"http://web-01.esetautomation.tech/fx-market-watch/";

String firstName = 'first_name';
String lastName = 'last_name';
String userName = 'username';
String interests = 'interests';
String password = 'password';

String userId = 'user_id';
String userAlreadyExistError = 'The User already exist';

Map<String, String> head = {
  "Access-Control-Allow-Origin": "*",
  'HOST': 'market price alert',
  'Content-Type': 'application/json',
  'Accept-Charset': 'UTF-8',
};

Map<String, String> loginHead = {
  'Access-Control-Allow-Origin': '*',
  'HOST': 'market price alert',
  'Content-Type': 'application/x-www-form-urlencoded',
  'Accept-Charset': 'UTF-8',
};
