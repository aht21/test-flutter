class Content {
  final int id;
  final int userId;
  final String title;
  final String body;

  Content({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json['id'] as int,
        userId: json['userId'] as int,
        title: json['title'] as String,
        body: json['body'] as String,
      );
}
