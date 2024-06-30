import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/common/utils/logger.dart';

part 'new_find_state.dart';

class NewFindCubit extends Cubit<NewFindState> {
  NewFindCubit() : super(InitialState()) {
    availableCameras().catchError((error) {
      Logger.d('Failed to get available cameras ($error)');
      return error;
    }).then((cameras) {
      final cameraController = CameraController(
        cameras.first,
        ResolutionPreset.max,
      );
      cameraController.initialize().catchError((error) {
        Logger.d('Failed to initialize camera ($error)');
        return error;
      }).then((_) {
        emit(CameraReadyState(
          cameraController: cameraController,
        ));
      });
    });
  }

  void savePhoto(
    String photoPath,
    CameraController cameraController,
  ) {
    emit(PhotoTakenState(
      photoPath: photoPath,
      cameraController: cameraController,
    ));
  }

  Future<void> saveFind({
    required String fossilType,
    required String geologicalPeriod,
    required String findDescription,
    required String discoveryPlace,
    required String discoveryDate,
  }) async {
    // TODO
    print(
        'fossilType=$fossilType; geologicalPeriod=$geologicalPeriod; findDescription=$findDescription; discoveryPlace=$discoveryPlace; discoveryDate=$discoveryDate');
    return Future.value(null);
  }
}
