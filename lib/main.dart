import 'package:flutter/material.dart';
import 'package:flutter_application/di/di.dart';
import 'package:flutter_application/flutter_application.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  FlutterError.onError = (details) {
    talker.handle(details.exception, details.stack);
  };

  runApp(const AppName());
}
