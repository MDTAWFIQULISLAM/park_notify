import 'package:flutter/material.dart';
import 'package:park_notify/presentation/get_started_screen.dart';
import 'package:park_notify/presentation/signin_page.dart';
import 'package:park_notify/presentation/password_screen.dart';
import 'package:park_notify/presentation/create_account_screen.dart';
import 'package:park_notify/presentation/register_your_vehicle_screen.dart';
import 'package:park_notify/presentation/Map_page.dart';
import 'package:park_notify/presentation/confirmed_parked_status.dart';
import 'package:park_notify/presentation/location_search.dart';

class AppRoutes {
  static const String getStartedScreen = '/get_started_screen';
  static const String signInPage = '/signin_page';
  static const String passwordScreen = '/password_screen';
  static const String createAccountScreen = '/create_account_screen';
  static const String registerYourVehicleScreen = '/register_your_vehicle_screen';
  static const String mapPage = '/Map_page';
  static const String confirmedParkedStatus = '/confirmed_parked_status';
  static const String searchPage = '/location_search';


  static Map<String, WidgetBuilder> routes = {
    getStartedScreen: (context) => GetStartedScreen(),
    signInPage: (context) => SignInPage(),
    passwordScreen: (context) => PasswordScreen(),
    createAccountScreen: (context) => CreateAccountScreen(),
    registerYourVehicleScreen: (context) => RegisterYourVehicleScreen(),
    mapPage: (context) => MapPage(),
    confirmedParkedStatus: (context) => ConfirmedParkedStatus(),
    searchPage: (context) => SearchPage()
  };
}
