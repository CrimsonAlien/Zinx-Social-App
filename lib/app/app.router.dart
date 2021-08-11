// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../ui/views/Loading_screen.dart';
import '../ui/views/create_account_view.dart';
import '../ui/views/create_profile.dart';
import '../ui/views/login_view.dart';
import '../ui/views/set_password.dart';
import '../ui/views/signup_page.dart';
import '../ui/views/startup_view.dart';
import '../ui/views/user/user_main_screen.dart';
import '../ui/views/verify_email.dart';

class Routes {
  static const String loadingScreen = '/';
  static const String startPage = '/start-page';
  static const String loginViewPage = '/login-view-page';
  static const String signupPage = '/signup-page';
  static const String createAccount = '/create-account';
  static const String verifyEmail = '/verify-email';
  static const String setAccountPassword = '/set-account-password';
  static const String createProfile = '/create-profile';
  static const String userMainScreen = '/user-main-screen';
  static const all = <String>{
    loadingScreen,
    startPage,
    loginViewPage,
    signupPage,
    createAccount,
    verifyEmail,
    setAccountPassword,
    createProfile,
    userMainScreen,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.loadingScreen, page: LoadingScreen),
    RouteDef(Routes.startPage, page: StartPage),
    RouteDef(Routes.loginViewPage, page: LoginViewPage),
    RouteDef(Routes.signupPage, page: SignupPage),
    RouteDef(Routes.createAccount, page: CreateAccount),
    RouteDef(Routes.verifyEmail, page: VerifyEmail),
    RouteDef(Routes.setAccountPassword, page: SetAccountPassword),
    RouteDef(Routes.createProfile, page: CreateProfile),
    RouteDef(Routes.userMainScreen, page: UserMainScreen),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    LoadingScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoadingScreen(),
        settings: data,
      );
    },
    StartPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => StartPage(),
        settings: data,
      );
    },
    LoginViewPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginViewPage(),
        settings: data,
      );
    },
    SignupPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SignupPage(),
        settings: data,
      );
    },
    CreateAccount: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => CreateAccount(),
        settings: data,
      );
    },
    VerifyEmail: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => VerifyEmail(),
        settings: data,
      );
    },
    SetAccountPassword: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SetAccountPassword(),
        settings: data,
      );
    },
    CreateProfile: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => CreateProfile(),
        settings: data,
      );
    },
    UserMainScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => UserMainScreen(),
        settings: data,
      );
    },
  };
}
