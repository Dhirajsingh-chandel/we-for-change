import 'package:flutter/cupertino.dart';

class NotificationData {
  final List<Data> data;
  NotificationData({this.data});
  factory NotificationData.fromJson(Map<String, dynamic> responseData) {
    var list = responseData['data'] as List;
    List<Data> notificationList = list.map((i) => Data.fromJson(i)).toList();

    return NotificationData(data: notificationList);
  }
}

class Data {
  int id;
  String message;
  bool status;
  int user_id;
  Data({this.id, this.message, this.status, this.user_id});
  factory Data.fromJson(Map<String, dynamic> responseData) {
    return Data(
        id: responseData["id"],
        message: responseData["message"],
        status: responseData["status"],
        user_id: responseData["user_id"]);
  }
}
