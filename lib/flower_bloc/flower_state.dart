part of 'flower_bloc.dart';

sealed class FlowerState extends Equatable {
  const FlowerState();
  
  @override
  List<Object> get props => [];
}

final class FlowerInitial extends FlowerState {}
