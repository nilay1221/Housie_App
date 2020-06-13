part of 'caller_bloc.dart';

@immutable
abstract class CallerEvent {}

class LoadData extends CallerEvent{}

class CallNumber extends CallerEvent{}

class DataReset extends CallerEvent{}


class ClearCurrentWinners extends CallerEvent{}

class ToggleSound extends CallerEvent{}