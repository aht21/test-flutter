import 'package:flutter_application/data/models/content.dart';

abstract interface class ContentRepositoryInterface {
  Future<List<Content>> getContent();
  Future<Content> getContentById(int id);
}
