part of 'map_bloc.dart';

abstract class MapState {}

class Initial extends MapState {}

class ErrorState extends MapState {
  String msgKey;

  ErrorState({
    required this.msgKey,
  });
}
