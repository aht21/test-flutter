class Endpoints {
  Endpoints._();

  static const String content = 'posts';
  static String contentById(int id) => 'posts/$id';
}
