part of 'caller_bloc.dart';

@immutable
abstract class CallerState {}

class CallerInitial extends CallerState {}


class CallerStart extends CallerState{}

class CallerRunning extends CallerState{

  final CallerData data;

  CallerRunning({this.data});

  int get number => this.data.number;
  List<int> get numbers => this.data.numbers;
  List<String> get winners => this.data.ticketsLoaded.current_winners;
  bool get soundOn => this.data.soundOn;


}

class CallerEnd extends CallerState{}


