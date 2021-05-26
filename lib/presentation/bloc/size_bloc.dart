import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'size_event.dart';
part 'size_state.dart';

class SizeBloc extends Bloc<SizeEvent, SizeState> {
  final double sideBarWidth;
  SizeBloc({this.sideBarWidth = 350}) : super(WidthState(double.infinity));

  @override
  Stream<SizeState> mapEventToState(
    SizeEvent event,
  ) async* {
    if (event is WidthEvent) {
      yield WidthState(event.width);
    }
  }

  bool get isMobileScreen =>
      state is WidthState && (state as WidthState).width < 2 * sideBarWidth
          ? true
          : false;
}
