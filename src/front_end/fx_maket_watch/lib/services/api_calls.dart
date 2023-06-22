///api calls for

import 'dart:async';
import 'dart:convert';

import "package:fx_maket_watch/constants.dart" as constants;
import 'package:http/http.dart';

import '../models/alert_model.dart';

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
Future<Response> login(
    {required String userName, required String password}) async {
  var address = '${constants.apiUrl}/token';

  var link = Uri.parse(address);
  var loginBody = {
    constants.userName: userName,
    constants.password: password,
  };

  var response = await post(link, headers: constants.loginHead, body: loginBody)
      .then((value) => value)
      .onError(
        (error, stackTrace) => throw (error.toString()),
      );

  return response;

  // if (response.statusCode == 200) {
  //   var jsonData = jsonDecode(response.body) as List<String>;

  //   print(jsonData);
  //   return jsonData.toString();
  // } else {
  //   throw (response.body);
  // }
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
    }
    if (value.statusCode == 401) {
      //let user know that authentication error has occured
      //maybe because of expored auth credentail
      throw ('401');
    }
    throw (json.decode(value.body));
  }).onError((error, stackTrace) => throw (error.toString()));
}

/// Add new  or update alert if already exist.
/// update is detectedif the alert already have alert_id.
/// this will automatically call the update route of the API
Future<Map<String, dynamic>> addAlert(
    {required PriceAlert newAlert, required String token}) async {
  var address = '${constants.apiUrl}/user/create-alert';
  var link = Uri.parse(address);
  var updatedHead = constants.getReqHead; //constants.loginHead;
  var myBody = newAlert.toJson();
  updatedHead.addAll(
      {'accept': ' application/json', 'Authorization': 'Bearer $token'});

  if (newAlert.alertId != null) {
    //Edit Existing alert
    var editAddress = '${constants.apiUrl}/user/edit-alert';
    var editLink = Uri.parse(editAddress);

    try {
      var response = await put(editLink,
          body: jsonEncode(newAlert.toJson(forUpdate: true)),
          headers: updatedHead);
      if (response.statusCode == 202) {
        // print(response.body);
        return jsonDecode(response.body);
      } else {
        print(response.body);
        throw (response.body);
      }
    } catch (e) {
      print(e.toString());
      throw (e.toString());
    }
  } else {
    //Create new Alert
    try {
      var response =
          await post(link, body: jsonEncode(myBody), headers: updatedHead);
      if (response.statusCode == 201) {
        // print(response.body);
        return json.decode(response.body);
      } else {
        // print(response.statusCode);

        throw (response.body.toString());
      }
    } catch (e) {
      throw (e.toString());
    }
  }
}

Future<String> getAllAlerts({required String token}) async {
  var address = '${constants.apiUrl}/user/show-alerts';
  var link = Uri.parse(address);
  var updatedHead = constants.getReqHead; //constants.loginHead;
  updatedHead.addAll(
      {'accept': ' application/json', 'Authorization': 'Bearer $token'});

  try {
    var response = await get(link, headers: updatedHead);
    if (response.statusCode == 200) {
      // print(response.body);
      return response.body;
    } else {
      throw (response.body);
    }
  } catch (e) {
    throw (e.toString());
  }
}

Future<Map<String, dynamic>> deleteAlert(
    {required int alertId, required String token}) async {
  var address = '${constants.apiUrl}/user/delete-alert';
  var link = Uri.parse(address);
  var updatedHead = constants.getReqHead; //constants.loginHead;
  updatedHead.addAll(
      {'accept': ' application/json', 'Authorization': 'Bearer $token'});
  Map<String, dynamic> deleteBody = {'alert_id': alertId};

  try {
    var response = await delete(
      link,
      headers: updatedHead,
      body: jsonEncode(deleteBody),
    );
    if (response.statusCode == 202) {
      return jsonDecode(response.body);
    } else {
      throw (response.body);
    }
  } catch (e) {
    throw (e.toString());
  }
}
