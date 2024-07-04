part of 'map_cubit.dart';

@immutable
sealed class MapState {}

final class FossilsDownloadingState extends MapState {}

final class RefreshState extends MapState {}

final class ErrorState extends MapState {
  final String errorMessageKey;

  ErrorState({
    required this.errorMessageKey,
  });
}
