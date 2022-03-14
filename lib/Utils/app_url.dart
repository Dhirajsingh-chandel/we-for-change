class AppUrl {
  static const String liveBaseURL = "https://we-for-change.herokuapp.com/api";

  static const String register = liveBaseURL + "/create_user/";
  static const String login = liveBaseURL + "/login_user/";
  static const String createComplaint = liveBaseURL + "/create_complaint/";
  static const String getComplaint = liveBaseURL + "/create_complaint/";
  static const String myComplaint = liveBaseURL + "/user_complaints/";
  static const String likeComplaint = liveBaseURL + "/like_complaint/";
  static const String resolvedComplaint = liveBaseURL + "/resolved_status/";
  static const String dislikeComplaint = liveBaseURL + "/dislike_complaint/";
  static const String notification = liveBaseURL + "/notification/";
  static const String addAdmin = liveBaseURL + '/create_worker/';
  static const String updateComplaint = liveBaseURL + '/resolved_status/';
  static const String getDepartmentComplaint =
      liveBaseURL + '/get_departmentcomplaints/';
  static const String logout = liveBaseURL + '/logout_user/';
}
