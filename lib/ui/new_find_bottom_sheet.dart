import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/dimens.dart';
import 'package:flutter_template/common/utils/app_locale_utils.dart';
import 'package:flutter_template/common/utils/toast_utils.dart';
import 'package:flutter_template/cubit/new_find/new_find_cubit.dart';
import 'package:flutter_template/ui/camera_widget.dart';
import 'package:get_it/get_it.dart';

class NewFindBottomSheet extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final ToastUtils _toastUtils = GetIt.instance.get<ToastUtils>();

  NewFindBottomSheet({
    super.key,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    final AppLocaleUtils appLocaleUtils = AppLocaleUtils.of(context);
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(
          Dimens.marginStandard,
          Dimens.marginStandard,
          Dimens.marginStandard,
          MediaQuery.of(context).viewInsets.bottom + Dimens.marginStandard,
        ),
        child: Form(
          key: formKey,
          child: BlocBuilder<NewFindCubit, NewFindState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: Dimens.marginStandard),
                  Text(appLocaleUtils.translate('new_find.photo')),
                  if (state is PhotoTakenState)
                    Container(
                      height: 250,
                      margin: const EdgeInsets.only(top: Dimens.marginStandard),
                      alignment: Alignment.center,
                      child: Image.file(
                        File(state.photoPath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  const SizedBox(height: Dimens.marginStandard),
                  if (state is InitialState)
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  else if (state is CameraReadyState)
                    _getCameraWidget(context, state.cameraController)
                  else if (state is PhotoTakenState)
                    _getCameraWidget(context, state.cameraController),
                  const SizedBox(height: Dimens.marginStandard),
                  Text('Rodzaj skamieniałości'),
                  TextFormField(
                    // Add your fossil type input field here
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'To pole jest wymagane';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  Text('Okres geologiczny'),
                  TextFormField(
                    // Add your geological period input field here
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'To pole jest wymagane';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  Text('Opis znaleziska'),
                  TextFormField(
                    // Add your description input field here
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'To pole jest wymagane';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  Text('Miejsce odkrycia'),
                  TextFormField(
                    // Add your discovery location input field here
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'To pole jest wymagane';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  Text('Data odkrycia'),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'To pole jest wymagane';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (state is! PhotoTakenState) {
                        _toastUtils.showToast(
                            'new_find.photo_required', context);
                        return;
                      }
                      if (formKey.currentState?.validate() == true) {
                        // Handle form submission
                        Navigator.pop(context); // Close the bottom sheet
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _getCameraWidget(
    BuildContext context,
    CameraController cameraController,
  ) {
    return Center(
      child: FloatingActionButton(
        child: const Icon(Icons.photo_camera),
        onPressed: () => _openCamera(context, cameraController),
      ),
    );
  }

  void _openCamera(
    BuildContext context,
    CameraController cameraController,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraWidget(
          cameraController: cameraController,
        ),
      ),
    ).then((photoPath) {
      if (photoPath is String) {
        BlocProvider.of<NewFindCubit>(context)
            .savePhoto(photoPath, cameraController);
      }
    });
  }
}
