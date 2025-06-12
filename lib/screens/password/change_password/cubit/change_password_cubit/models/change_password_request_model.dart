class ChangePasswordRequestModel {
  String? oldPassword;
  String? newPassword;
  String? confirmPassword;

  ChangePasswordRequestModel(
      {this.oldPassword, this.newPassword, this.confirmPassword});

  ChangePasswordRequestModel.fromJson(Map<String, dynamic> json) {
    oldPassword = json['oldPassword'];
    newPassword = json['newPassword'];
    confirmPassword = json['confirmPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['oldPassword'] = this.oldPassword;
    data['newPassword'] = this.newPassword;
    data['confirmPassword'] = this.confirmPassword;
    return data;
  }
}