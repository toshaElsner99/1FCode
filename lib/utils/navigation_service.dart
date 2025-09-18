import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

extension StringRouteExtensition on String {
  Future<dynamic> pushNamed({dynamic args}) async =>
      await NavigationService.navigatorKey.currentState!
          .pushNamed(this, arguments: args);

  Future<dynamic> pushNamedAndRemoveUntil({dynamic args}) async =>
      await NavigationService.navigatorKey.currentState!
          .pushNamedAndRemoveUntil(this, (dynamic) => false, arguments: args);

  void popUntil() => NavigationService.navigatorKey.currentState!
      .popUntil(ModalRoute.withName(this));

  Future<dynamic> pushReplacementNamed({dynamic args, dynamic results}) async =>
      await NavigationService.navigatorKey.currentState!
          .pushReplacementNamed(this, arguments: args, result: results);

  Future<dynamic> popAndPushNamed({dynamic args, dynamic results}) async =>
      await NavigationService.navigatorKey.currentState!
          .popAndPushNamed(this, arguments: args, result: results);
}

class NavigationService {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext get context => navigatorKey.currentState!.context;

  dynamic pop({dynamic data}) => navigatorKey.currentState!.pop(data);
}

final locator = GetIt.instance;

void setInitial() {
  locator.registerSingleton<NavigationService>(NavigationService());
}
