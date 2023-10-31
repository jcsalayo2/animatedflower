part of 'hello_bloc.dart';

class HelloEvent extends Equatable {
  const HelloEvent();

  @override
  List<Object> get props => [];
}

class StartHelloAnimationEvent extends HelloEvent {
  final String text;
  @override
  List<Object> get props => [];

  const StartHelloAnimationEvent({required this.text});
}
