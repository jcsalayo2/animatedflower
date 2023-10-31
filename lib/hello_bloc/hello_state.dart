part of 'hello_bloc.dart';

class HelloState extends Equatable {
  final List<bool> animateLetters;

  const HelloState({
    required this.animateLetters,
  });

  HelloState.initial() : animateLetters = [];

  @override
  List<Object> get props => [
        animateLetters,
      ];

  HelloState copyWith({
    List<bool>? animateLetters,
  }) {
    return HelloState(
      animateLetters: animateLetters ?? this.animateLetters,
    );
  }
}
