part of 'new_find_cubit.dart';

@immutable
sealed class NewFindState {}

final class InitialState extends NewFindState {}

final class PhotoTakenState extends NewFindState {
  final String photoPath;

  PhotoTakenState({
    required this.photoPath,
  });
}
