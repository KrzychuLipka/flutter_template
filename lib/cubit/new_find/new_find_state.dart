part of 'new_find_cubit.dart';

@immutable
sealed class NewFindState {}

final class NewFindInitialState extends NewFindState {}

final class NewFindRefreshingState extends NewFindState {}

final class FindSavingState extends NewFindState {}

final class FindSavedState extends NewFindState {}
