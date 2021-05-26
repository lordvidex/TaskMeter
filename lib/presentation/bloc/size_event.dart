part of 'size_bloc.dart';

abstract class SizeEvent extends Equatable {
  const SizeEvent();

  @override
  List<Object> get props => [];
}

class WidthEvent extends SizeEvent {
  final double width;
  WidthEvent(this.width);
  @override
  List<Object> get props => [this.width];
}
