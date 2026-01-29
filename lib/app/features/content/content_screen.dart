import 'package:flutter/material.dart';
import 'package:flutter_application/di/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application/app/features/content/content_bloc.dart';
import 'package:flutter_application/app/features/favorites/favorites_bloc.dart';

class ContentScreen extends StatefulWidget {
  final int id;

  const ContentScreen({super.key, required this.id});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  late final ContentBloc _bloc;
  late final FavoritesBloc _favoritesBloc;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _bloc = getIt<ContentBloc>();
    _favoritesBloc = getIt<FavoritesBloc>();
    _bloc.add(ContentLoad(widget.id));
  }

  void _toggleFavorite() {
    if (_isFavorite) {
      _favoritesBloc.add(FavoritesRemove(contentId: widget.id));
    } else {
      final state = _bloc.state;
      if (state is ContentLoaded) {
        _favoritesBloc.add(FavoritesAdd(content: state.item));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _bloc),
        BlocProvider.value(value: _favoritesBloc),
      ],
      child: BlocListener<ContentBloc, ContentState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is ContentLoaded) {
            _favoritesBloc.add(FavoritesCheckStatus(contentId: widget.id));
          }
        },
        child: BlocListener<FavoritesBloc, FavoritesState>(
          bloc: _favoritesBloc,
          listener: (context, state) {
            if (state is FavoritesStatusChecked) {
              setState(() {
                _isFavorite = state.isFavorite;
              });
            } else if (state is FavoritesLoaded) {
              _favoritesBloc.add(FavoritesCheckStatus(contentId: widget.id));
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text('Post #${widget.id}'),
              actions: [
                BlocBuilder<ContentBloc, ContentState>(
                  bloc: _bloc,
                  builder: (context, contentState) {
                    if (contentState is ContentLoaded) {
                      return BlocBuilder<FavoritesBloc, FavoritesState>(
                        bloc: _favoritesBloc,
                        builder: (context, favoritesState) {
                          return IconButton(
                            icon: Icon(
                              _isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: Colors.white,
                            ),
                            onPressed: _toggleFavorite,
                          );
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
            body: BlocBuilder<ContentBloc, ContentState>(
              bloc: _bloc,
              builder: (context, state) {
                if (state is ContentLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ContentLoaded) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            'assets/images/pic2.jpg',
                            width: double.infinity,
                            height: 400,
                            fit: BoxFit.cover,
                          ),
                        ),
                        
                        const SizedBox(height: 20),

                        Text(
                          state.item.title,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),

                        const SizedBox(height: 12),

                        Text(
                          state.item.body,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  );
                } else if (state is ContentError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Error: ${state.message}'),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () => _bloc.add(ContentLoad(widget.id)),
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
          ),
        ),
      ),
    );
  }
}
