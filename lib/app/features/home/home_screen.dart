import 'package:flutter/material.dart';
import 'package:flutter_application/app/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Header',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            ListView.separated(
              primary: false,
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (_, index) => ContentCard(id: index),
              separatorBuilder: (_, __) => const SizedBox(height: 16),
            ),
          ],
        ),
      ),
    );
  }
}
