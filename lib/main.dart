import 'package:flutter/material.dart';
import 'package:oneFCode/screens/bottom_navigation_bar_screen.dart';
import 'package:oneFCode/screens/view_bank_details_screen.dart';
import 'package:oneFCode/utils/app_routes.dart';
import 'package:oneFCode/utils/navigation_service.dart';
import 'package:oneFCode/utils/app_colors.dart';
import 'flavor_config/environment.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColor.primary,
        ),
      ),
      navigatorKey: NavigationService.navigatorKey,
      onGenerateRoute: (setting) {
        final routes = RouteGenerator.routes(setting);
        final WidgetBuilder builder = routes[setting.name]!;
        return CustomTransition(
          builder: builder,
          settings: setting,
        );
      },
      debugShowCheckedModeBanner: false,
      home: ViewBankDetailsScreen(),
    );
  }
}
