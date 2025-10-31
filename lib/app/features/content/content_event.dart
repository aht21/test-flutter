part of 'content_bloc.dart';

abstract class ContentEvent extends Equatable {
  const ContentEvent();

  @override
  List<Object> get props => [];
}

class ContentLoad extends ContentEvent {
  final int id;

  const ContentLoad(this.id);

  @override
  List<Object> get props => [id];
}
