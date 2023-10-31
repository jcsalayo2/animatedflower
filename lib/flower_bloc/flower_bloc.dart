import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'flower_event.dart';
part 'flower_state.dart';

class FlowerBloc extends Bloc<FlowerEvent, FlowerState> {
  FlowerBloc() : super(FlowerInitial()) {
    on<FlowerEvent>((event, emit) {});
  }
}
