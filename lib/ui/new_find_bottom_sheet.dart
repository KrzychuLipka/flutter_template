import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/dimens.dart';
import 'package:flutter_template/common/utils/app_locale_utils.dart';
import 'package:flutter_template/cubit/new_find/new_find_cubit.dart';

class NewFindBottomSheet extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const NewFindBottomSheet({
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
                  if (state is InitialState)
                    const SizedBox(
                      height: 500,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  if (state is CameraReadyState)
                    SizedBox(
                      height: 500,
                      child: CameraPreview(state.cameraController),
                    ),
                  if (state is PhotoTakenState)
                    SizedBox(
                      height: 500,
                      child: Image.file(File(state.photoPath)),
                    ),
                  Center(
                    child: FloatingActionButton(
                      onPressed: () {
                        if (state is CameraReadyState) {
                          BlocProvider.of<NewFindCubit>(context)
                              .takePhoto(state.cameraController);
                        } else if (state is PhotoTakenState) {
                          BlocProvider.of<NewFindCubit>(context)
                              .showCameraPreview(state.cameraController);
                        }
                      },
                      child: const Icon(Icons.photo_camera),
                    ),
                  ),
                  const SizedBox(height: Dimens.marginDouble),
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
}
