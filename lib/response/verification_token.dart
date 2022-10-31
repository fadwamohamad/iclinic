class ResponseVerification{
  String? token;

  ResponseVerification({this.token});
  ResponseVerification.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['token'] = token;
    return data;
  }
}