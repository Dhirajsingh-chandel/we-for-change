import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:we_for_change/Models/notificationData.dart';
import 'package:we_for_change/Utils/SharedPreferencesHelper.dart';
import 'package:we_for_change/Utils/app_url.dart';

class NotificationProvider with ChangeNotifier {
  Future<Map<String, dynamic>> notifications() async {
    var result;
    String authentication = await SharedPreferencesHelper.getAuthToken();

    var requestedUrl = AppUrl.notification;
    print(requestedUrl);
    Response response = await get(
      Uri.parse(requestedUrl),
      headers: {
        'Content-Type': 'application/json',
        'authorization': 'bearer ' + authentication
      },
    );

    print(response.body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      var notificationData = responseData;
      NotificationData notifications =
          NotificationData.fromJson(notificationData);
      result = {
        'status': true,
        'message': json.decode(response.body)['message'],
        'notification': notifications
      };
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body)['message']
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> seenNotifications(int notificationId) async {
    var result;
    String authentication = await SharedPreferencesHelper.getAuthToken();

    var requestedUrl = AppUrl.notification + '$notificationId/';
    print(requestedUrl);
    Response response = await put(
      Uri.parse(requestedUrl),
      headers: {
        'Content-Type': 'application/json',
        'authorization': 'bearer ' + authentication
      },
    );

    if (response.statusCode == 200) {
      // final Map<String, dynamic> responseData = json.decode(response.body);
      // var notificationData = responseData;
      // NotificationData notifications =
      //     NotificationData.fromJson(notificationData);
      result = {
        'status': true,
        'message': json.decode(response.body)['message'],
        // 'notification': notifications
      };
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body)['message']
      };
    }
    return result;
  }
}
