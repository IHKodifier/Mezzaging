import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zimster_messaging/app/service_locator.dart';

import 'app/app.dart';

Future<void> main() async {
  // TODO:      Register all the models and services before the app starts
 
 WidgetsFlutterBinding.ensureInitialized();
  registerAllServicesWithLocator();

   await  Firebase.initializeApp();

  runApp(App());
}
