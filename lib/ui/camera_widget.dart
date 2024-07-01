import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/common/dimens.dart';
import 'package:flutter_template/common/utils/logger.dart';
import 'package:flutter_template/common/utils/toast_utils.dart';
import 'package:get_it/get_it.dart';

class CameraWidget extends StatelessWidget {
  final ToastUtils _toastUtils = GetIt.instance.get<ToastUtils>();

  CameraWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initCameraController(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          Logger.d('${snapshot.error}');
          Navigator.pop(context);
          return Container();
        }
        if (snapshot.hasData && snapshot.data != null) {
          final cameraController = snapshot.data!;
          return Stack(
            children: [
              CameraPreview(cameraController),
              Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.all(Dimens.marginStandard),
                child: FloatingActionButton(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.black,
                  onPressed: () => _takePhoto(context, cameraController),
                  child: const Icon(Icons.photo_camera),
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<CameraController> _initCameraController() async {
    final cameras = await availableCameras();
    final cameraController = CameraController(cameras[0], ResolutionPreset.max);
    await cameraController.initialize();
    return cameraController;
  }

  void _takePhoto(
    BuildContext context,
    CameraController cameraController,
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
