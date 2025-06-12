class SignInRequestModel {
  String? emailOrUserName;
  String? password;

  SignInRequestModel({this.emailOrUserName, this.password});

  SignInRequestModel.fromJson(Map<String, dynamic> json) {
    emailOrUserName = json['emailOrUserName'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emailOrUserName'] = this.emailOrUserName;
    data['password'] = this.password;
    return data;
  }
}