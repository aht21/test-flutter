import 'package:dio/dio.dart';
import 'package:flutter_application/data/models/content.dart';
import 'package:flutter_application/data/repositories/content_repository_interface.dart';
import 'package:flutter_application/data/dio/endpoints.dart';

class ContentRepository implements ContentRepositoryInterface {
  ContentRepository({required this.dio});

  final Dio dio;

  @override
  Future<List<Content>> getContent() async {
    try {
      print('🔵 getContent() called');
      final response = await dio.get(Endpoints.content);
      print('🟢 Response received: ${response.data}');

      // jsonplaceholder возвращает список
      final content = (response.data as List)
          .map((e) => Content.fromJson(e as Map<String, dynamic>))
          .toList();

      return content;
    } on DioException catch (e) {
      print('🔴 Dio error: ${e.message}');
      throw e.message.toString();
    }
  }
}
