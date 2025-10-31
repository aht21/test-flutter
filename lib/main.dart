import 'package:flutter/material.dart';
import 'package:flutter_application/di/di.dart';
import 'package:flutter_application/flutter_application.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUpDio();
  await setupLocator();
  

  FlutterError.onError = (details) {
    talker.handle(details.exception, details.stack);
  };

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const AppName());
}
