import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application/data/models/content.dart';
import 'package:flutter_application/data/repositories/content_repository_interface.dart';
import 'package:flutter_application/di/locator.dart';

part 'content_event.dart';
part 'content_state.dart';

class ContentBloc extends Bloc<ContentEvent, ContentState> {
  final ContentRepositoryInterface repository;

  ContentBloc(this.repository) : super(ContentInitial()) {
    on<ContentLoad>(_onLoad);
  }

  Future<void> _onLoad(ContentLoad event, Emitter<ContentState> emit) async {
    try {
      emit(ContentLoading());
      final item = await repository.getContentById(event.id);
      emit(ContentLoaded(item));
    } catch (e, st) {
      talker.handle(e, st);
      emit(ContentError(e.toString()));
    }
  }
}
