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

  void takePhoto(
    CameraController cameraController,
  ) async {
    try {
      final image = await cameraController.takePicture();
      emit(PhotoTakenState(
        photoPath: image.path,
        cameraController: cameraController,
      ));
    } catch (error) {
      Logger.d('Failed to take photo ($error)');
    }
  }

  void showCameraPreview(
    CameraController cameraController,
  ) {
    emit(CameraReadyState(
      cameraController: cameraController,
    ));
  }
}
