import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:mhub/view_models/cart.viewmodel.dart';

import '../__lib.dart';

final authViewModel = ChangeNotifierProvider<AuthViewModel>(
  (ref) => AuthViewModel(
    authRemoteRepo: AuthRemoteRepoImp(),
  ),
);

class AuthViewModel extends ChangeNotifier {
  final AuthRemoteRepo authRemoteRepo;

  AuthViewModel({
    required this.authRemoteRepo,
  });
  LocalUser? localCred;

  final context = Get.context!;

  String? _token;

  User? _user;
  User? get user => _user;

  String? get token => _token;

  String? _userId;
  String? get userId => _userId;

  void setToken(String? token) {
    _token = token;
  }

  Future logIn({
    required LogInData logIn,
    required String emailAddress,
    required String password,
  }) async {
    _token = logIn.token;
    _userId = logIn.userId;
  }

  Future setUserProfile({required User? user}) async {
    _user = user;
  }

  Future setUserId({required String? userId}) async {
    _userId = userId;
  }

  void onLogOut() {
    _user = null;
    _token = null;
    _userId = null;
    context.read(cartViewModel).stopPolling;
    replaceScreen(const SignInScreen());
  }
}
