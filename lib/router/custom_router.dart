import 'package:blocauth/Home/home.dart';
import 'package:blocauth/login/login_screen.dart';
import 'package:blocauth/signup/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomRouter {
  static Route onGenrateRoute(RouteSettings setting) {
    switch (setting.name) {
      case LoginScreen.routeName:
        return LoginScreen.route();
      case SignUpScreen.routeName:
        return SignUpScreen.route();
      case Home.routeName:
        return Home.route();
    }
  }
}
