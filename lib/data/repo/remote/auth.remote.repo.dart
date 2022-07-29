import 'dart:async';

import 'package:mhub/data/models/create_account_response.dart';

import './services/__services.remote.repo.dart' as http;
import '../../../__lib.dart';

abstract class AuthRemoteRepo {
  Future<EmptyResponse> createAccount(
      {required String email,
      required String password,
      required String fullName});

  Future<EmptyResponse> verifyEmail(
      {required String email, required String otp});
  Future<EmptyResponse> logIn(
      {required String email, required String password});

  Future<EmptyResponse> passwordResetRequest({required String email});
  Future<EmptyResponse> resetPassword(
      {required String userId,
      required String otp,
      required String newPassword});
}

class AuthRemoteRepoImp extends AuthRemoteRepo {
  @override
  Future<EmptyResponse> createAccount(
      {required String email,
      required String password,
      required String fullName}) async {
    final data = {
      'name': fullName,
      'password': password,
      'email': email.trim(),
    };
    final result =
        await http.post(path: http.ApiEndPoints.createAccount, data: data);
    if (result['success'] == false) {
      return ErrorResponse.fromJson(result);
    }
    return CreateAccountResponse.fromJson(result['user']);
  }

  @override
  Future<EmptyResponse> logIn(
      {required String email, required String password}) async {
    final data = {
      'email': email.trim(),
      'password': password,
    };
    final result = await http.post(
      path: http.ApiEndPoints.login,
      data: data,
    );

    if (result['user']['success'] == false) {
      return ErrorResponse.fromJson(result['user']);
    }
    return LogInResponse.fromJson(result['user']);
  }

  @override
  Future<EmptyResponse> passwordResetRequest({required String email}) async {
    final data = {'email': email.trim()};
    final result = await http.post(
      path: http.ApiEndPoints.passwordResetRequest,
      data: data,
    );
    if (result['user']['success'] == false) {
      return ErrorResponse.fromJson(result['user']);
    }
    return PasswordResetRequestResponse.fromJson(result['user']);
  }

  @override
  Future<EmptyResponse> resetPassword(
      {required String userId,
      required String otp,
      required String newPassword}) async {
    final data = {'userId': userId, 'otp': otp, 'newPassword': newPassword};
    final result =
        await http.post(path: http.ApiEndPoints.resetPassword, data: data);
    if (result['user']['success'] == false) {
      return ErrorResponse.fromJson(result['user']);
    }
    return EmptyResponse();
  }

  @override
  Future<EmptyResponse> verifyEmail(
      {required String email, required String otp}) async {
    final data = {'email': email.trim(), 'otp': otp};
    final result = await http.post(
        path: http.ApiEndPoints.verifyEmail, data: data, addAuth: false);
    if (result['user']['success'] == false) {
      return ErrorResponse.fromJson(result['user']);
    }
    return VerifyEmailResponse.fromJson(result['user']);
  }
}
