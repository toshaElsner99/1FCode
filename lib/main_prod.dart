import 'package:flutter/material.dart';
import 'flavor_config/environment.dart';
import 'main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Set Production server
  Constants.setEnvironment(Environment.PRODUCTION);
  runApp(MyApp());
}
