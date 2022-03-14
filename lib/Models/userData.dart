class UserData {
  Message message;
  Data data;

  // Configuration configuration;
  UserData({this.data, this.message});

  factory UserData.fromJson(Map<String, dynamic> responseData) {
    return UserData(
      message: responseData['message'] != null
          ? Message.fromJson(responseData['message'])
          : null,
      data: Data.fromJson(responseData['data']),
    );
  }
}

class Message {
  String message;
  Message({this.message});
  factory Message.fromJson(Map<String, dynamic> response) {
    return Message(message: response['message']);
  }
}

class Data {
  int userId;
  String name;
  String mobile_number;
  String address;
  String email;
  String role;
  String token;
  Data({
    this.userId,
    this.name,
    this.mobile_number,
    this.address,
    this.email,
    this.role,
    this.token,
  });
  factory Data.fromJson(Map<String, dynamic> responseData) {
    return Data(
        userId: responseData['user_id'],
        name: responseData['name'],
        mobile_number: responseData['mobile_number'],
        address: responseData['address'],
        email: responseData['email'],
        role: responseData['role'],
        token: responseData['token']);
  }
}
