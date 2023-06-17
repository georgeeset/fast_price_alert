///api calls for

import 'dart:convert';

import "package:fx_maket_watch/constants.dart" as constants;
import 'package:http/http.dart';

// class SimpleResponse {
//   final String field;
//   final String val;
//   const SimpleResponse({required this.field, required this.val});

//   @factory.fromJson({required Map<String, dnamic>json})
// }

///register new user
Future<Response> signup({
  required String userName,
  required String password,
  required String firstName,
  required String surname,
  required List<String> interests,
}) async {
  var address = '${constants.apiUrl}/add-user';

  var data = {
    constants.userName: userName,
    constants.password: password,
    constants.firstName: firstName,
    constants.lastName: surname,
    constants.interests: interests.join(','),
  };

  var link = Uri.parse(address);

  var response =
      await post(link, headers: constants.head, body: jsonEncode(data))
          .onError((error, stackTrace) {
    throw (error.toString());
  });
  return response;
}

/// login funciton for user
///
/// returns the user's token which will be used for
/// other activities
///
Future<String> login(
    {required String userName, required String password}) async {
  var address = '${constants.apiUrl}/token';

  var link = Uri.parse(address);
  var loginBody = {
    constants.userName: userName,
    constants.password: password,
  };

  try {
    var response =
        await post(link, headers: constants.loginHead, body: loginBody);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw (response.body);
    }
  } catch (e) {
    throw (e.toString());
  }
}

Future<List<Map<String, dynamic>>> getSupportedAssets() async {
  var address = '${constants.apiUrl}/get-supported-assets';
  var link = Uri.parse(address);

  return await get(link, headers: constants.getReqHead).then((value) {
    if (value.statusCode == 200) {
      var data = '[${value.body}]';

      List<dynamic> listify = jsonDecode(data) as List<dynamic>;
      List<dynamic> realData =
          listify[0][constants.commodities] as List<dynamic>;
      List<Map<String, dynamic>> newData =
          realData.map((e) => e as Map<String, dynamic>).toList();

      return newData;
    } else {
      throw (json.decode(value.body));
    }
  }).onError((error, stackTrace) => throw (error.toString()));
}

Future<List<Map<String, dynamic>>> getUserAlerMedium(
    {required String token}) async {
  var address = '${constants.apiUrl}/user/show-alert-medium';
  var link = Uri.parse(address);
  var updatedHead = constants.getReqHead;
  updatedHead.addAll({'Authorization': 'Bearer $token'});

  return await get(link, headers: constants.getReqHead).then((value) {
    if (value.statusCode == 200) {
      // var data = '[${value.body}]';

      List<dynamic> listify = jsonDecode(value.body) as List<dynamic>;
      // print(listify);
      // List<dynamic> realData =
      //     listify[0][constants.commodities] as List<dynamic>;

      // print(realData);

      List<Map<String, dynamic>> newData =
          listify.map((e) => e as Map<String, dynamic>).toList();
      // print(newData);
      return newData;
    } else {
      throw (json.decode(value.body));
    }
  }).onError((error, stackTrace) => throw (error.toString()));
}
