import 'package:flutter/material.dart';
import 'package:park_notify/presentation/get_started_screen.dart';
import 'package:park_notify/presentation/login_two_screen.dart';
import 'package:park_notify/presentation/password_screen.dart';
import 'package:park_notify/presentation/create_account_screen.dart';
import 'package:park_notify/presentation/register_your_vehicle_screen.dart';
import 'package:park_notify/presentation/app_navigation_screen.dart';

class AppRoutes {
  static const String getStartedScreen = '/get_started_screen';

  static const String loginTwoScreen = '/login_two_screen';

  static const String passwordScreen = '/password_screen';

  static const String createAccountScreen = '/create_account_screen';

  static const String registerYourVehicleScreen = '/register_your_vehicle_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    getStartedScreen: (context) => GetStartedScreen(),
    loginTwoScreen: (context) => LoginTwoScreen(),
    passwordScreen: (context) => PasswordScreen(),
    createAccountScreen: (context) => CreateAccountScreen(),
    registerYourVehicleScreen: (context) => RegisterYourVehicleScreen(),
    appNavigationScreen: (context) => AppNavigationScreen()
  };
}