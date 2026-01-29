import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application/app/widgets/widgets.dart';
import 'package:flutter_application/di/di.dart';
import 'package:flutter_application/app/features/favorites/favorites_bloc.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late final FavoritesBloc _favoritesBloc;

  @override
  void initState() {
    super.initState();
    _favoritesBloc = getIt<FavoritesBloc>();
    _favoritesBloc.add(const FavoritesLoad());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        bloc: _favoritesBloc,
        builder: (context, state) {
          if (state is FavoritesInitial || state is FavoritesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavoritesLoaded) {
            if (state.favorites.isEmpty) {
              return const Center(
                child: Text('Favorites list is empty'),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.favorites.length,
              itemBuilder: (_, index) => ContentCard(
                content: state.favorites[index],
              ),
              separatorBuilder: (_, __) => const SizedBox(height: 16),
            );
          } else if (state is FavoritesError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Error: ${state.message}'),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => _favoritesBloc.add(const FavoritesLoad()),
                      child: const Text('Retry'),
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
