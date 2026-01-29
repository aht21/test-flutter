import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application/data/models/content.dart';
import 'package:flutter_application/data/services/favorites_service.dart';
import 'package:flutter_application/di/di.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesServiceInterface favoritesService;

  FavoritesBloc(this.favoritesService) : super(FavoritesInitial()) {
    on<FavoritesLoad>(_favoritesLoad);
    on<FavoritesAdd>(_favoritesAdd);
    on<FavoritesRemove>(_favoritesRemove);
    on<FavoritesCheckStatus>(_favoritesCheckStatus);
  }

  Future<void> _favoritesLoad(
      FavoritesLoad event, Emitter<FavoritesState> emit) async {
    try {
      emit(FavoritesLoading());
      final favorites = await favoritesService.getFavorites();
      emit(FavoritesLoaded(favorites: favorites));
    } catch (exception, stackTrace) {
      emit(FavoritesError(message: exception.toString()));
      talker.handle(exception, stackTrace);
    }
  }

  Future<void> _favoritesAdd(
      FavoritesAdd event, Emitter<FavoritesState> emit) async {
    try {
      await favoritesService.addToFavorites(event.content);
      // Обновляем список избранного после добавления
      add(FavoritesLoad());
    } catch (exception, stackTrace) {
      emit(FavoritesError(message: exception.toString()));
      talker.handle(exception, stackTrace);
    }
  }

  Future<void> _favoritesRemove(
      FavoritesRemove event, Emitter<FavoritesState> emit) async {
    try {
      await favoritesService.removeFromFavorites(event.contentId);
      // Обновляем список избранного после удаления
      add(FavoritesLoad());
    } catch (exception, stackTrace) {
      emit(FavoritesError(message: exception.toString()));
      talker.handle(exception, stackTrace);
    }
  }

  Future<void> _favoritesCheckStatus(
      FavoritesCheckStatus event, Emitter<FavoritesState> emit) async {
    try {
      final isFavorite = await favoritesService.isFavorite(event.contentId);
      emit(FavoritesStatusChecked(isFavorite: isFavorite));
    } catch (exception, stackTrace) {
      emit(FavoritesError(message: exception.toString()));
      talker.handle(exception, stackTrace);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    talker.handle(error, stackTrace);
  }
}
