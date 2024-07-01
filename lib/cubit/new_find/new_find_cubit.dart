import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/common/utils/logger.dart';
import 'package:flutter_template/data/repository/paleo_repository.dart';

part 'new_find_state.dart';

class NewFindCubit extends Cubit<NewFindState> {
  TextEditingController get findDescriptionController =>
      _findDescriptionController;
  final TextEditingController _findDescriptionController =
      TextEditingController();

  TextEditingController get discoveryPlaceController =>
      _discoveryPlaceController;
  final TextEditingController _discoveryPlaceController =
      TextEditingController();

  String _photoPath = '';
  String _fossilType = PaleoRepository.fossilTypes.first;
  String _geologicalPeriod = PaleoRepository.geologicalPeriods.first;
  String _discoveryDate = '';

  NewFindCubit() : super(InitialState());

  void savePhoto(
    String photoPath,
  ) {
    _photoPath = photoPath;
    emit(PhotoTakenState(
      photoPath: photoPath,
    ));
  }

  void saveFossilType(
    String fossilType,
  ) {
    _fossilType = fossilType;
  }

  void saveGeologicalPeriod(
    String geologicalPeriod,
  ) {
    _geologicalPeriod = geologicalPeriod;
  }

  void saveDiscoveryDate(
    String discoveryDate,
  ) {
    _discoveryDate = discoveryDate;
  }

  bool isPhotoSaved() => _photoPath.trim().isNotEmpty;

  Future<void> saveFind() async {
    if (_discoveryDate.trim().isEmpty) {
      _discoveryDate = DateTime.now().toIso8601String();
    }
    Logger.d(
        'photo: $_photoPath, fossilType=$_fossilType; geologicalPeriod=$_geologicalPeriod; findDescription=${_findDescriptionController.text}; discoveryPlace=${_discoveryPlaceController.text}; discoveryDate=$_discoveryDate');
    return Future.value(null);
  }
}
