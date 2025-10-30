import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

import 'package:flutter_application/app/features/home/home_bloc.dart';
import 'package:flutter_application/data/repositories/content_repository.dart';
import 'package:flutter_application/data/repositories/content_repository_interface.dart';

final getIt = GetIt.instance;
final talker = TalkerFlutter.init();

final Dio dio = Dio();

Future<void> setupLocator() async {
  setUpDio();

  getIt.registerSingleton(talker);

  getIt.registerSingleton<ContentRepositoryInterface>(
    ContentRepository(dio: dio),
  );

  getIt.registerSingleton(
    HomeBloc(getIt.get<ContentRepositoryInterface>()),
  );
}

void setUpDio() {
  dio.options.baseUrl = 'https://jsonplaceholder.typicode.com';
  dio.options.connectTimeout = const Duration(seconds: 5);
  dio.options.receiveTimeout = const Duration(seconds: 5);

  dio.interceptors.addAll([
    TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(
        printRequestData: true,
        printRequestHeaders: true,
        printResponseData: true,
        printResponseHeaders: false,
        printErrorData: true,
      ),
    ),
  ]);
}
