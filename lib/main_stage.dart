import 'package:flutter/material.dart';
import 'flavor_config/environment.dart';
import 'main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Set Staging server
  Constants.setEnvironment(Environment.STAGING);
  runApp(MyApp());
}