import 'package:flutter/material.dart';
import 'package:park_notify/presentation/get_started_screen.dart';
import 'package:park_notify/presentation/signin_page.dart';
import 'package:park_notify/presentation/password_screen.dart';
import 'package:park_notify/presentation/create_account_screen.dart';
import 'package:park_notify/presentation/register_your_vehicle_screen.dart';
import 'package:park_notify/presentation/refined_final_screen.dart';
import 'package:park_notify/presentation/enter_destination_maimuna_screen.dart';
import 'package:park_notify/presentation/choose_parking_one_screen.dart';
import 'package:park_notify/presentation/choose_parking_two_screen.dart';
import 'package:park_notify/presentation/choose_parking_four_screen.dart';
import 'package:park_notify/presentation/confirmation_screen.dart';
import 'package:park_notify/presentation/app_navigation_screen.dart';
import 'package:park_notify/presentation/Map_page.dart';

class AppRoutes {
  static const String getStartedScreen = '/get_started_screen';

  static const String signInPage = '/signin_page';

  static const String passwordScreen = '/password_screen';

  static const String createAccountScreen = '/create_account_screen';

  static const String registerYourVehicleScreen = '/register_your_vehicle_screen';

  static const String refinedFinalScreen = '/refined_final_screen';

  static const String mapPageRefinedTanvirScreen = '/map_page_refined_tanvir_screen';

  static const String enterDestinationMaimunaScreen = '/enter_destination_maimuna_screen';

  static const String chooseParkingOneScreen = '/choose_parking_one_screen';

  static const String chooseParkingTwoScreen = '/choose_parking_two_screen';

  static const String chooseParkingFourScreen = '/choose_parking_four_screen';

  static const String confirmationScreen = '/confirmation_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String mapPage = '/Map_page';

  static Map<String, WidgetBuilder> routes = {
    getStartedScreen: (context) => GetStartedScreen(),
    signInPage: (context) => SignInPage(),
    passwordScreen: (context) => PasswordScreen(),
    createAccountScreen: (context) => CreateAccountScreen(),
    registerYourVehicleScreen: (context) => RegisterYourVehicleScreen(),
    refinedFinalScreen: (context) => RefinedFinalScreen(),
    enterDestinationMaimunaScreen: (context) => EnterDestinationMaimunaScreen(),
    chooseParkingOneScreen: (context) => ChooseParkingOneScreen(),
    chooseParkingTwoScreen: (context) => ChooseParkingTwoScreen(),
    chooseParkingFourScreen: (context) => ChooseParkingFourScreen(),
    confirmationScreen: (context) => ConfirmationScreen(),
    appNavigationScreen: (context) => AppNavigationScreen(),
    mapPage: (context) => MapPage()
  };
}
