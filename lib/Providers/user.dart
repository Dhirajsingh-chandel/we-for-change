import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:we_for_change/Models/userData.dart';
import 'package:we_for_change/Utils/SharedPreferencesHelper.dart';
import 'package:we_for_change/Utils/app_url.dart';

class UserProvider with ChangeNotifier {
  UserData _user = new UserData();

  UserData get user => _user;

  void setUser(UserData user) {
    _user = user;
  }

  Future<Map<String, dynamic>> authenticate(
      String email, String password, String token) async {
    var result;

    final Map<String, dynamic> loginData = {
      "email": email,
      "password": password,
      "device": token
    };
    Response response = await post(
      Uri.parse(AppUrl.login),
      body: json.encode(loginData),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      var userData = responseData;
      UserData authUser = UserData.fromJson(userData);
      SharedPreferencesHelper.setEmail(authUser.data.email.toString());
      SharedPreferencesHelper.setAuthToken(authUser.data.token.toString());
      SharedPreferencesHelper.setUserId(authUser.data.userId.toString());
      SharedPreferencesHelper.setRole(authUser.data.role.toString());
      result = {
        'status': true,
        'message': authUser.message.message,
        'user': authUser
      };
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body)['message']
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> logout() async {
    var result;

    Response response = await post(
      Uri.parse(AppUrl.logout),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      result = {
        'status': true,
        'message': 'Logout Successfully!',
      };
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body)['message']
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> registration(
      String username,
      String email,
      String password,
      String name,
      String address,
      String mobileNumber,
      String role,
      String device) async {
    var result;
    // ignore: non_constant_identifier_names
    final Map<String, dynamic> RegisterData = {
      "username": username,
      "email": email,
      "password": password,
      "name": name,
      "address": address,
      "mobile_number": mobileNumber,
      "role": role,
      "device": device.toString()
    };
    Response response = await post(
      Uri.parse(AppUrl.register),
      body: json.encode(RegisterData),
      headers: {'Content-Type': 'application/json'},
    );
    final Map<String, dynamic> responseData = json.decode(response.body);
    var userData = responseData;
    UserData authUser = UserData.fromJson(userData);
    if (response.statusCode == 201) {
      result = {
        'status': true,
        'message': authUser.message.message.toString(),
      };
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body)['message']
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> addAdmin(
      String username,
      String email,
      String password,
      String name,
      String address,
      String mobileNumber,
      String role,
      String department) async {
    var result;
    // ignore: non_constant_identifier_names
    final Map<String, dynamic> AdminData = {
      "username": username,
      "email": email,
      "password": password,
      "name": name,
      "address": address,
      "mobile_number": mobileNumber,
      "role": role,
      "department": department
    };
    String authentication = await SharedPreferencesHelper.getAuthToken();
    Response response = await post(
      Uri.parse(AppUrl.addAdmin),
      body: json.encode(AdminData),
      headers: {
        'Content-Type': 'application/json',
        'authorization': 'bearer ' + authentication
      },
    );
    print(response.body);
    print(response.statusCode);
    final Map<String, dynamic> responseData = json.decode(response.body);
    var userData = responseData;
    UserData authUser = UserData.fromJson(userData);
    if (response.statusCode == 201) {
      result = {
        'status': true,
        'message': authUser.message.message.toString(),
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
