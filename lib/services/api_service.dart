import 'package:boxify/constants/api_constant.dart';
import 'package:boxify/screens/auth/sign_in/cubit/models/sign_in_request_model.dart';
import 'package:boxify/screens/auth/sign_in/cubit/models/sign_in_response_model.dart';
import 'package:boxify/screens/auth/sign_up/cubit/models/sign_up_request_model.dart';
import 'package:boxify/screens/auth/sign_up/cubit/models/sign_up_response_model.dart';

import 'api_client.dart';

class ApiService {
  //SignIn
  Future<SignInResponseModel?> signIn(SignInRequestModel request) async {
    final response = await ApiClient.dio.post(
      signInApiEndPoint,
      data: request.toJson(),
    );
    return SignInResponseModel.fromJson(response.data);
  }


  //SignUp
  Future<SignUpResponseModel?> signUp(SignUpRequestModel request) async {
    final response = await ApiClient.dio.post(
      signUpApiEndPoint,
      data: request.toJson(),
    );
    return SignUpResponseModel.fromJson(response.data);
  }

  //ChangePassword


}
