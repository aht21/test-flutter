import 'package:dio/dio.dart';
import 'package:flutter_application/app/features/content/content_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

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

  getIt.registerSingleton(ContentBloc(
  getIt.get<ContentRepositoryInterface>(),
));

}

void setUpDio() {
  dio.options.baseUrl = 'https://jsonplaceholder.typicode.com/';
  dio.options.connectTimeout = const Duration(seconds: 5);
  dio.options.receiveTimeout = const Duration(seconds: 5);
  dio.options.validateStatus = (status) => status != null && status < 500;
  dio.options.headers.addAll({
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  });

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