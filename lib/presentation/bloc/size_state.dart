part of 'size_bloc.dart';

abstract class SizeState extends Equatable {
  const SizeState();

  @override
  List<Object> get props => [];
}

class WidthState extends SizeState {
  final double width;
  WidthState(this.width);
  @override

  List<Object> get props => [this.width];
}
