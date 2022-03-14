// ignore_for_file: non_constant_identifier_names

class ComplaintData {
  Message message;
  final List<Data> data;

  // Configuration configuration;
  ComplaintData({this.data, this.message});

  factory ComplaintData.fromJson(Map<String, dynamic> responseData) {
    var list = responseData['data'] as List;
    List<Data> complaintList = list.map((i) => Data.fromJson(i)).toList();
    return ComplaintData(
      message: responseData['message'] != null
          ? Message.fromJson(responseData['message'])
          : null,
      data: complaintList,
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
  int id;
  int uploaded_by;
  String title;
  String description;
  String image;
  int like;
  int dislike;
  int complaint_status;
  bool user_liked;
  Data(
      {this.description,
      this.id,
      this.image,
      this.title,
      this.uploaded_by,
      this.like,
      this.dislike,
      this.complaint_status,
      this.user_liked});
  factory Data.fromJson(Map<String, dynamic> responseData) {
    return Data(
        id: responseData['complaint_id'],
        uploaded_by: responseData['uploaded_by'],
        title: responseData['title'],
        description: responseData['description'],
        like: responseData["Likes"],
        dislike: responseData["Dislikes"],
        image: responseData['image'],
        user_liked: responseData['user_liked'],
        complaint_status: responseData['complaint_status']);
  }
}

class Likedata {
  CountData countData;
  bool Like;
  Likedata({this.countData, this.Like});
  factory Likedata.fromJson(Map<String, dynamic> responseData) {
    return Likedata(
        Like: responseData['Like'],
        countData: CountData.fromJson(responseData['data']));
  }
}

class CountData {
  int Likes;
  int Dislikes;
  CountData({this.Dislikes, this.Likes});
  factory CountData.fromJson(Map<String, dynamic> responseData) {
    return CountData(
        Dislikes: responseData['Dislikes'], Likes: responseData['Likes']);
  }
}

class SingleComplaintData {
  String message;
  Single single;
  SingleComplaintData({this.message, this.single});
  factory SingleComplaintData.fromJson(Map<String, dynamic> responseData) {
    return SingleComplaintData(
        message: responseData['message'],
        single: Single.fromJson(responseData['data']));
  }
}

class Single {
  int complaint_id;
  int uploaded_by;
  String title;
  String description;
  int complaint_status;
  String department;
  Single(
      {this.complaint_id,
      this.complaint_status,
      this.department,
      this.description,
      this.title,
      this.uploaded_by});
  factory Single.fromJson(Map<String, dynamic> responseData) {
    return Single(
        complaint_id: responseData['complaint_id'],
        complaint_status: responseData['complaint_status'],
        department: responseData['department'],
        title: responseData['title'],
        uploaded_by: responseData['uploaded_by']);
  }
}
