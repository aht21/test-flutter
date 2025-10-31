import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application/app/widgets/widgets.dart';
import 'package:flutter_application/di/di.dart';
import 'package:flutter_application/app/features/home/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _home = getIt<HomeBloc>();

  @override
  void initState() {
    super.initState();
    _home.add(HomeLoad());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: _home,
        builder: (context, state) {
          if (state is HomeLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeLoadSuccess) {
            final content = state.content;
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: content.length,
              itemBuilder: (_, index) => ContentCard(content: content[index]),
              separatorBuilder: (_, __) => const SizedBox(height: 16),
            );
          } else if (state is HomeLoadFailure) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Error: ${state.exception}'),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => _home.add(const HomeLoad()),
                      child: const Text('Reload'),
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
