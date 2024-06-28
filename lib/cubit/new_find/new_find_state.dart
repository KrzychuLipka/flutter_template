part of 'new_find_cubit.dart';

@immutable
sealed class NewFindState {}

final class InitialState extends NewFindState {}

final class CameraReadyState extends NewFindState {
  final CameraController cameraController;

  CameraReadyState({
    required this.cameraController,
  });
}

final class PhotoTakenState extends NewFindState {
  final String photoPath;
  final CameraController cameraController;

  PhotoTakenState({
    this.photoPath = '',
    required this.cameraController,
  });
}
