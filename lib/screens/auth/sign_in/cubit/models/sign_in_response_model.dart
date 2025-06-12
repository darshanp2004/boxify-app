class SignInResponseModel {
  bool? success;
  Meta? meta;
  Data? data;

  SignInResponseModel({this.success, this.meta, this.data});

  SignInResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Meta {
  int? statusCode;
  String? message;
  String? error;
  bool? isSuccess;

  Meta({this.statusCode, this.message, this.error, this.isSuccess});

  Meta.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    error = json['error'];
    isSuccess = json['isSuccess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    data['error'] = this.error;
    data['isSuccess'] = this.isSuccess;
    return data;
  }
}

class Data {
  int? id;
  String? username;
  String? email;
  String? address;
  String? profilePicture;
  String? token;
  String? loginTime;
  double? latitude;
  double? longitude;
  bool? notificationEnable;

  Data(
      {this.id,
        this.username,
        this.email,
        this.address,
        this.profilePicture,
        this.token,
        this.loginTime,
        this.latitude,
        this.longitude,
        this.notificationEnable});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    address = json['address'];
    profilePicture = json['profilePicture'];
    token = json['token'];
    loginTime = json['loginTime'];
    latitude = json['latitude']?.toDouble();
    longitude = json['longitude']?.toDouble();
    notificationEnable = json['notificationEnable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['address'] = this.address;
    data['profilePicture'] = this.profilePicture;
    data['token'] = this.token;
    data['loginTime'] = this.loginTime;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['notificationEnable'] = this.notificationEnable;
    return data;
  }
}