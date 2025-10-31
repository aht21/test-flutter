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
      final response = await dio.get(Endpoints.content);
      if (response.statusCode == 200) {
        final content = (response.data as List)
            .map((e) => Content.fromJson(e as Map<String, dynamic>))
            .toList();
        return content;
      }
      final code = response.statusCode;
      final data = response.data;
      throw Exception('Failed to load content (status: $code, body: $data)');
    } on DioException catch (e) {
      final code = e.response?.statusCode;
      throw Exception('Network error loading content (status: $code): ${e.message}');
    }
  }

  @override
  Future<Content> getContentById(int id) async {
    try {
      final response = await dio.get(Endpoints.contentById(id));
      if (response.statusCode == 200) {
        return Content.fromJson(response.data);
      }
      final code = response.statusCode;
      final data = response.data;
      throw Exception('Failed to load post $id (status: $code, body: $data)');
    } on DioException catch (e) {
      final code = e.response?.statusCode;
      throw Exception('Network error loading post $id (status: $code): ${e.message}');
    }
  }
}
