

import 'package:flutter/material.dart';
import 'package:oneFCode/screens/sign_in_screen.dart';
import 'package:oneFCode/screens/selfie_screen.dart';
import 'package:oneFCode/screens/pan_verification_screen.dart';
import 'package:oneFCode/screens/profile_screen.dart';
import 'package:oneFCode/screens/bottom_navigation_bar_screen.dart';
import 'package:oneFCode/screens/home_screen.dart';
import 'package:oneFCode/screens/quiz_screen.dart';
import 'package:oneFCode/screens/add_bank_details_screen.dart';

class RouteConstant {
  static final signInScreen = 'signInScreen';
  static final selfieScreen = 'selfieScreen';
  static final panVerificationScreen = 'panVerificationScreen';
  static final profileScreen = 'profileScreen';
  static final bottomNavigationBarScreen = 'bottomNavigationBarScreen';
  static final homeScreen = 'homeScreen';
  static final quizScreen = 'quizScreen';
  static final addBankDetailsScreen = 'addBankDetailsScreen';
}

class RouteGenerator {
  static Map<String, WidgetBuilder> routes(RouteSettings settings) => {
    RouteConstant.signInScreen: (context) => SignInScreen(),
    RouteConstant.selfieScreen: (context) => const SelfieScreen(),
    RouteConstant.panVerificationScreen: (context) => const PanVerificationScreen(),
    RouteConstant.profileScreen: (context) => const ProfileScreen(),
    RouteConstant.bottomNavigationBarScreen: (context) => BottomNavigationBarScreen(),
    RouteConstant.homeScreen: (context) => const HomeScreen(),
    RouteConstant.quizScreen: (context) => const QuizScreen(),
    RouteConstant.addBankDetailsScreen: (context) => const AddBankDetailsScreen(),
  };
}

class CustomTransition<T> extends PageRouteBuilder<T> {
  final WidgetBuilder builder;
  @override
  final RouteSettings settings;

  CustomTransition({required this.builder, required this.settings})
      : super(
    pageBuilder: (context, animation, secondAnimation) =>
        builder(context),
    transitionsBuilder: (context, animation, secondAnimation, child) {
      var curve = Curves.ease;
      var tween =
      Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));
      return FadeTransition(
        opacity: animation.drive(tween),
        child: child,
      );
    },
    opaque: false,
    transitionDuration: const Duration(milliseconds: 500),
    settings: settings,
  );
}
