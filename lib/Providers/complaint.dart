import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:we_for_change/Models/complaintData.dart';
import 'package:we_for_change/Utils/SharedPreferencesHelper.dart';
import 'package:we_for_change/Utils/app_url.dart';
import 'package:http/http.dart';

class ComplaintProvider with ChangeNotifier {
  Future<Map<String, dynamic>> createComplaint(String address, String title,
      String description, File image, String department) async {
    var result;
    print(image);
    // var stream = new http.ByteStream(DelegatingStream.typed(image.openRead()));
    String authentication = await SharedPreferencesHelper.getAuthToken();

    final Map<String, dynamic> complaintData = {
      "location": address,
      "description": description,
      "department": department,
      "title": title,
      "image": base64UrlEncode(image.readAsBytesSync())
    };
    Response response = await post(
      Uri.parse(AppUrl.createComplaint),
      body: json.encode(complaintData),
      headers: {
        'Content-Type': 'application/json',
        'authorization': 'bearer ' + authentication
      },
    );
    print(AppUrl.createComplaint);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 201) {
      result = {
        'status': true,
        'message': json.decode(response.body)['message'],
      };
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body)['message']
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> getDeptComplaint() async {
    var result;
    String authentication = await SharedPreferencesHelper.getAuthToken();
    // final Map<String, dynamic> complaintData = {
    //   "location": address,
    //   "description": description,
    //   "department": department,
    //   "title": title,
    //   "image": base64UrlEncode(image.readAsBytesSync())
    // };
    Response response = await get(
      Uri.parse(AppUrl.getDepartmentComplaint),
      headers: {
        'Content-Type': 'application/json',
        'authorization': 'bearer ' + authentication
      },
    );

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      var complaintData = responseData;
      ComplaintData complaint = ComplaintData.fromJson(complaintData);
      result = {
        'status': true,
        'message': json.decode(response.body)['message'],
        'complaint': complaint
      };
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body)['message']
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> updateComplaint(
      int status, int complaintId) async {
    var result;
    String authentication = await SharedPreferencesHelper.getAuthToken();
    final Map<String, dynamic> statusData = {
      "status": status,
    };
    Response response = await put(
        Uri.parse(AppUrl.updateComplaint + '$complaintId/'),
        headers: {
          'Content-Type': 'application/json',
          'authorization': 'bearer ' + authentication
        },
        body: json.encode(statusData));

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      var complaintData = responseData;
      SingleComplaintData complaint =
          SingleComplaintData.fromJson(complaintData);
      result = {
        'status': true,
        'message': json.decode(response.body)['message'],
        'complaint_status': complaint.single.complaint_status
      };
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body)['message']
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> likeComplaint(int complaintId) async {
    var result;
    String authentication = await SharedPreferencesHelper.getAuthToken();
    var requestedUrl = AppUrl.likeComplaint + '$complaintId/';
    Response response = await post(
      Uri.parse(requestedUrl),
      headers: {
        'Content-Type': 'application/json',
        'authorization': 'bearer ' + authentication
      },
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      var likeData = responseData;
      Likedata count = Likedata.fromJson(likeData);
      result = {
        'status': true,
        'message': json.decode(response.body)['message'],
        'like_count': count.countData.Likes,
        'dislike_count': count.countData.Dislikes,
        'like_colour': count.Like
      };
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body)['message']
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> dislikeComplaint(int complaintId) async {
    var result;
    String authentication = await SharedPreferencesHelper.getAuthToken();
    var requestedUrl = AppUrl.dislikeComplaint + '$complaintId/';
    Response response = await post(
      Uri.parse(requestedUrl),
      headers: {
        'Content-Type': 'application/json',
        'authorization': 'bearer ' + authentication
      },
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      var dislikeData = responseData;
      Likedata count = Likedata.fromJson(dislikeData);
      result = {
        'status': true,
        'message': json.decode(response.body)['message'],
        'like_count': count.countData.Likes,
        'dislike_count': count.countData.Dislikes,
        'like_colour': count.Like
      };
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body)['message']
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> getComplaint() async {
    var result;
    String authentication = await SharedPreferencesHelper.getAuthToken();
    // final Map<String, dynamic> complaintData = {
    //   "location": address,
    //   "description": description,
    //   "department": department,
    //   "title": title,
    //   "image": base64UrlEncode(image.readAsBytesSync())
    // };
    Response response = await get(
      Uri.parse(AppUrl.getComplaint),
      headers: {
        'Content-Type': 'application/json',
        'authorization': 'bearer ' + authentication
      },
    );

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      var complaintData = responseData;
      ComplaintData complaint = ComplaintData.fromJson(complaintData);
      result = {
        'status': true,
        'message': json.decode(response.body)['message'],
        'complaint': complaint
      };
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body)['message']
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> myComplaint() async {
    var result;
    String authentication = await SharedPreferencesHelper.getAuthToken();
    String userId = await SharedPreferencesHelper.getUserId();

    var requestedUrl = AppUrl.myComplaint + '$userId/';
    print(requestedUrl);
    Response response = await get(
      Uri.parse(requestedUrl),
      headers: {
        'Content-Type': 'application/json',
        'authorization': 'bearer ' + authentication
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      var complaintData = responseData;
      ComplaintData complaint = ComplaintData.fromJson(complaintData);
      result = {
        'status': true,
        'message': json.decode(response.body)['message'],
        'complaint': complaint
      };
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body)['message']
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> resolvedComplaint() async {
    var result;
    String authentication = await SharedPreferencesHelper.getAuthToken();

    var requestedUrl = AppUrl.resolvedComplaint;
    print(requestedUrl);
    Response response = await get(
      Uri.parse(requestedUrl),
      headers: {
        'Content-Type': 'application/json',
        'authorization': 'bearer ' + authentication
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      var complaintData = responseData;
      ComplaintData complaint = ComplaintData.fromJson(complaintData);
      result = {
        'status': true,
        'message': json.decode(response.body)['message'],
        'complaint': complaint
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
