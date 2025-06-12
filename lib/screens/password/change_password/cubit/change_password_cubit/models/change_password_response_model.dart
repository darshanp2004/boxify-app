class ChangePasswordResponseModel {
  bool? success;
  Meta? meta;
  String? data;

  ChangePasswordResponseModel({this.success, this.meta, this.data});

  ChangePasswordResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    data['data'] = this.data;
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