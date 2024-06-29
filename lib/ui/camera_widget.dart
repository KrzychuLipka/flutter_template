import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/common/dimens.dart';
import 'package:flutter_template/common/utils/logger.dart';
import 'package:flutter_template/common/utils/toast_utils.dart';
import 'package:get_it/get_it.dart';

class CameraWidget extends StatelessWidget {
  final CameraController cameraController;
  final ToastUtils _toastUtils = GetIt.instance.get<ToastUtils>();

  CameraWidget({
    super.key,
    required this.cameraController,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CameraPreview(cameraController),
        Container(
          alignment: Alignment.bottomCenter,
          margin: const EdgeInsets.all(Dimens.marginStandard),
          child: FloatingActionButton(
            backgroundColor: Colors.amber,
            foregroundColor: Colors.black,
            onPressed: () => _takePhoto(context),
            child: const Icon(Icons.photo_camera),
          ),
        ),
      ],
    );
  }

  void _takePhoto(
    BuildContext context,
  ) {
    cameraController.takePicture().catchError((error) {
      Logger.d('Failed to take photo ($error)');
      _toastUtils.showToast('new_find.failed_to_take_photo', context);
      Navigator.pop(context);
      return error;
    }).then((photo) {
      Navigator.pop(context, photo.path);
    });
  }
}
