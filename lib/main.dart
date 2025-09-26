import 'package:flutter/material.dart';
import 'package:oneFCode/screens/profile_settings_screen.dart';
import 'package:oneFCode/screens/splash_screen.dart';
import 'package:oneFCode/screens/view_mutual_fund_details_screen.dart';
import 'package:oneFCode/screens/view_stock_details_screen.dart';
import 'package:oneFCode/utils/app_routes.dart';
import 'package:oneFCode/utils/navigation_service.dart';
import 'package:oneFCode/utils/app_colors.dart';
import 'flavor_config/environment.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      home: ProfileSettingsScreen(),
    );
  }
}
