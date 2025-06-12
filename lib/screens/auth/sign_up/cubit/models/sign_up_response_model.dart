class SignUpResponseModel {
  bool? success;
  Meta? meta;
  Data? data;

  SignUpResponseModel({this.success, this.meta, this.data});

  SignUpResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? userName;
  String? email;
  String? profilePicture;
  double? latitude;
  double? longitude;
  String? token;
  bool? notificationEnable;
  int? roleId;
  String? createdAt;
  bool? isActive;
  bool? isDeleted;

  Data(
      {this.id,
        this.userName,
        this.email,
        this.profilePicture,
        this.latitude,
        this.longitude,
        this.token,
        this.notificationEnable,
        this.roleId,
        this.createdAt,
        this.isActive,
        this.isDeleted});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    email = json['email'];
    profilePicture = json['profilePicture'];
    latitude = json['latitude']?.toDouble();
    longitude = json['longitude']?.toDouble();
    token = json['token'];
    notificationEnable = json['notificationEnable'];
    roleId = json['roleId'];
    createdAt = json['createdAt'];
    isActive = json['isActive'];
    isDeleted = json['isDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['profilePicture'] = this.profilePicture;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['token'] = this.token;
    data['notificationEnable'] = this.notificationEnable;
    data['roleId'] = this.roleId;
    data['createdAt'] = this.createdAt;
    data['isActive'] = this.isActive;
    data['isDeleted'] = this.isDeleted;
    return data;
  }
}
