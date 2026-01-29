part of 'favorites_bloc.dart';

sealed class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

final class FavoritesInitial extends FavoritesState {}

final class FavoritesLoading extends FavoritesState {}

final class FavoritesLoaded extends FavoritesState {
  const FavoritesLoaded({required this.favorites});
  final List<Content> favorites;

  @override
  List<Object> get props => [favorites];
}

final class FavoritesStatusChecked extends FavoritesState {
  const FavoritesStatusChecked({required this.isFavorite});
  final bool isFavorite;

  @override
  List<Object> get props => [isFavorite];
}

final class FavoritesError extends FavoritesState {
  const FavoritesError({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}
