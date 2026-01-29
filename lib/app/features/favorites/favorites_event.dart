part of 'favorites_bloc.dart';

sealed class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class FavoritesLoad extends FavoritesEvent {
  const FavoritesLoad();
}

class FavoritesAdd extends FavoritesEvent {
  const FavoritesAdd({required this.content});
  final Content content;

  @override
  List<Object> get props => [content];
}

class FavoritesRemove extends FavoritesEvent {
  const FavoritesRemove({required this.contentId});
  final int contentId;

  @override
  List<Object> get props => [contentId];
}

class FavoritesCheckStatus extends FavoritesEvent {
  const FavoritesCheckStatus({required this.contentId});
  final int contentId;

  @override
  List<Object> get props => [contentId];
}
