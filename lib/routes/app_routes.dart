import 'package:flutter/material.dart';
import 'package:park_notify/presentation/get_started_screen.dart';
import 'package:park_notify/presentation/user/login_two_screen.dart';
import 'package:park_notify/presentation/user/password_screen.dart';
import 'package:park_notify/presentation/user/create_account_screen.dart';
import 'package:park_notify/presentation/user/register_your_vehicle_screen.dart';
import 'package:park_notify/presentation/map_page_refined_tanvir_screen.dart';
import 'package:park_notify/presentation/refined_final_screen.dart';
import 'package:park_notify/presentation/enter_destination_maimuna_screen.dart';
import 'package:park_notify/presentation/choose_parking_one_screen.dart';
import 'package:park_notify/presentation/choose_parking_two_screen.dart';
import 'package:park_notify/presentation/choose_parking_four_screen.dart';
import 'package:park_notify/presentation/confirmation_screen.dart';
import 'package:park_notify/presentation/app_navigation_screen.dart';

class AppRoutes {
  static const String getStartedScreen = '/get_started_screen';

  static const String loginTwoScreen = '/login_two_screen';

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


  static Map<String, WidgetBuilder> routes = {
    getStartedScreen: (context) => GetStartedScreen(),
    loginTwoScreen: (context) => LoginTwoScreen(),
    passwordScreen: (context) => PasswordScreen(username: '',),
    createAccountScreen: (context) => CreateAccountScreen(),
    registerYourVehicleScreen: (context) => RegisterYourVehicleScreen(),
    mapPageRefinedTanvirScreen: (context) => MapPageRefinedTanvirScreen(),
    refinedFinalScreen: (context) => RefinedFinalScreen(),
    enterDestinationMaimunaScreen: (context) => EnterDestinationMaimunaScreen(),
    chooseParkingOneScreen: (context) => ChooseParkingOneScreen(),
    chooseParkingTwoScreen: (context) => ChooseParkingTwoScreen(),
    chooseParkingFourScreen: (context) => ChooseParkingFourScreen(),
    confirmationScreen: (context) => ConfirmationScreen(),
    appNavigationScreen: (context) => AppNavigationScreen()
  };
}
