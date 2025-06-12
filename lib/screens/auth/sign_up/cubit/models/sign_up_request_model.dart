class SignUpRequestModel {
  String? userName;
  String? email;
  String? password;
  double? latitude;
  double? longitude;

  SignUpRequestModel(
      {this.userName,
        this.email,
        this.password,
        this.latitude,
        this.longitude});

  SignUpRequestModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    email = json['email'];
    password = json['password'];
    latitude = (json['latitude'] ).toDouble();
    longitude = (json['longitude'] ).toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}