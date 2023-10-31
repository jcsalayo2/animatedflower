import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'hello_event.dart';
part 'hello_state.dart';

class HelloBloc extends Bloc<HelloEvent, HelloState> {
  HelloBloc() : super(HelloState.initial()) {
    on<HelloEvent>((event, emit) {});
    on<StartHelloAnimationEvent>(_startAnimation);
  }

  FutureOr<void> _startAnimation(
      StartHelloAnimationEvent event, Emitter<HelloState> emit) async {
    var spacelessText = event.text.replaceAll(' ', '');

    emit(state.copyWith(
        animateLetters: List.generate(spacelessText.length, (index) => false)));

    while (true) {
      for (var (index, _) in spacelessText.characters.indexed) {
        await Future.delayed(const Duration(milliseconds: 500));
        var newList = state.animateLetters.toList();
        newList[index] = true;
        await Future.delayed(const Duration(milliseconds: 500));
        if (index > 0) {
          newList[index - 1] = false;
        } else {
          newList[spacelessText.length - 1] = false;
        }
        emit(state.copyWith(animateLetters: newList));
      }
    }
  }
}
