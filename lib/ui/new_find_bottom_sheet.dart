import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/dimens.dart';
import 'package:flutter_template/common/utils/app_locale_utils.dart';
import 'package:flutter_template/common/utils/logger.dart';
import 'package:flutter_template/common/utils/toast_utils.dart';
import 'package:flutter_template/cubit/new_find/new_find_cubit.dart';
import 'package:flutter_template/ui/camera_widget.dart';
import 'package:get_it/get_it.dart';

// TODO max size formatter
class NewFindBottomSheet extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final ToastUtils _toastUtils = GetIt.instance.get<ToastUtils>();
  final TextEditingController _fossilTypeController = TextEditingController();
  final TextEditingController _geologicalPeriodTypeController =
      TextEditingController();
  final TextEditingController _findDescriptionController = // TODO longer field
      TextEditingController();
  final TextEditingController
      _discoveryPlaceController = // TODO map place picker
      TextEditingController();
  final TextEditingController _discoveryDateController = // TODO date picker
      TextEditingController();

  NewFindBottomSheet({
    super.key,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    // TODO redundant code
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
                  const SizedBox(height: Dimens.marginDouble),
                  Text(appLocaleUtils.translate('new_find.fossil_type')),
                  TextFormField(
                    validator: _validator(appLocaleUtils),
                    controller: _fossilTypeController,
                  ),
                  const SizedBox(height: Dimens.marginStandard),
                  Text(appLocaleUtils.translate('new_find.geological_period')),
                  TextFormField(
                    validator: _validator(appLocaleUtils),
                    controller: _geologicalPeriodTypeController,
                  ),
                  const SizedBox(height: Dimens.marginStandard),
                  Text(appLocaleUtils.translate('new_find.find_description')),
                  TextFormField(
                    validator: _validator(appLocaleUtils),
                    controller: _findDescriptionController,
                  ),
                  const SizedBox(height: Dimens.marginStandard),
                  Text(appLocaleUtils.translate('new_find.discovery_place')),
                  TextFormField(
                    validator: _validator(appLocaleUtils),
                    controller: _discoveryPlaceController,
                  ),
                  const SizedBox(height: Dimens.marginStandard),
                  Text(appLocaleUtils.translate('new_find.discovery_date')),
                  TextFormField(
                    validator: _validator(appLocaleUtils),
                    controller: _discoveryDateController,
                  ),
                  const SizedBox(height: Dimens.marginDouble),
                  ElevatedButton(
                    onPressed: () {
                      if (state is! PhotoTakenState) {
                        _toastUtils.showToast(
                            'new_find.photo_required', context);
                        return;
                      }
                      if (formKey.currentState?.validate() == true) {
                        // TODO loader
                        BlocProvider.of<NewFindCubit>(context)
                            .saveFind(
                          fossilType: _fossilTypeController.text,
                          geologicalPeriod:
                              _geologicalPeriodTypeController.text,
                          findDescription: _findDescriptionController.text,
                          discoveryPlace: _discoveryPlaceController.text,
                          discoveryDate: _discoveryDateController.text,
                        )
                            .catchError((error) {
                          Logger.d('Failed to save the find');
                          _toastUtils.showToast('new_find.save_error', context);
                        }).then((_) {
                          _toastUtils.showToast(
                              'new_find.save_success', context);
                          Navigator.pop(context);
                        });
                      }
                    },
                    child: Text(
                      appLocaleUtils.translate('new_find.save_find'),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  FormFieldValidator<String> _validator(
    AppLocaleUtils appLocaleUtils,
  ) {
    return (value) {
      if (value == null || value.isEmpty) {
        return appLocaleUtils.translate('form.required_field');
      }
      return null;
    };
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
