import 'package:flutter/material.dart';

class ContentScreen extends StatelessWidget {
  final String contentId;

  const ContentScreen({super.key, required this.contentId});

  @override
  Widget build(BuildContext context) {
    // Для примера — статичные данные
    final content = {
      'title': 'Item $contentId',
      'description': 'This is a detailed description for item $contentId.',
      'image': 'assets/images/pic2.jpg',
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(content['title']!), 
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                content['image']!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              content['title']!,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              content['description']!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
