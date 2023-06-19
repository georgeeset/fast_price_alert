// store most of the constant strings for the web app

// const String apiUrl = "http://172.26.239.47:6003";

const String apiUrl = "http://web-01.esetautomation.tech/fx-market-watch";

const String firstName = 'first_name';
const String lastName = 'last_name';
const String userName = 'username';
const String interests = 'interests';
const String password = 'password';

const String userId = 'user_id';
const String userAlreadyExistError = 'The User already exist';

const Map<String, String> head = {
  "Access-Control-Allow-Origin": "*",
  'HOST': 'market price alert',
  'Content-Type': 'application/json',
  'Accept-Charset': 'UTF-8',
};

const Map<String, String> loginHead = {
  'Access-Control-Allow-Origin': '*',
  'HOST': 'market price alert',
  'Content-Type': 'application/x-www-form-urlencoded',
  'Accept-Charset': 'UTF-8',
};

Map<String, String> getReqHead = {
  'Content-Type': 'application/json',
};

const List<String> timeFrame = [
  timeFrameTitle,
  "m30",
  "H1",
  "H4",
  "D1",
  "W1",
  "M1",
];

List<String> conditionList = [
  conditionTitle,
  "Candle Closes ABOVE price",
  "Candle High is ABOVE price",
  "Candle Low is ABOVE Price",
  "Candle Closes BELOW price",
  "Candle High is BELOW price",
  "Candle Low is BELOW Price",
];

const String commodities = 'commodities';
const String timeFrameTitle = 'Time Frame';
const String commodityTitle = 'Asset';
const String conditionTitle = 'Condition';
const String alertMediumTitle = "Select";
