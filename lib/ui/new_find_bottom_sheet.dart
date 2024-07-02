import 'dart:io';

import 'package:camera/camera.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/dimens.dart';
import 'package:flutter_template/common/utils/app_locale_utils.dart';
import 'package:flutter_template/common/utils/toast_utils.dart';
import 'package:flutter_template/cubit/new_find/new_find_cubit.dart';
import 'package:flutter_template/data/repository/paleo_repository.dart';
import 'package:flutter_template/ui/camera_widget.dart';
import 'package:flutter_template/ui/dropdown_widget.dart';
import 'package:get_it/get_it.dart';

class NewFindBottomSheet extends StatelessWidget {
  static const _findDescriptionMaxLength = 250;
  static const _findDescriptionMinLines = 2;
  static const _findDescriptionMaxLines = 8;
  static const _discoveryPlaceMaxLength = 150;
  static const _discoveryPlaceLines = 4;
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
          child: BlocConsumer<NewFindCubit, NewFindState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: Dimens.marginStandard),
                  Text(appLocaleUtils.translate('new_find.photo')),
                  if (state is PhotoTakenState)
                    _getPhotoWidget(state.photoPath),
                  const SizedBox(height: Dimens.marginStandard),
                  _getCameraFabWidget(context),
                  const SizedBox(height: Dimens.marginDouble),
                  Text(appLocaleUtils.translate('new_find.fossil_type')),
                  _getDropdownWidget(
                    keyValue: 'fossilTypes',
                    data: PaleoRepository.fossilTypes,
                    valueChangeCallback: (value) {
                      BlocProvider.of<NewFindCubit>(context)
                          .saveFossilType(value);
                    },
                    context: context,
                  ),
                  const SizedBox(height: Dimens.marginStandard),
                  Text(appLocaleUtils.translate('new_find.geological_period')),
                  _getDropdownWidget(
                    keyValue: 'geologicalPeriods',
                    data: PaleoRepository.geologicalPeriods,
                    valueChangeCallback: (value) {
                      BlocProvider.of<NewFindCubit>(context)
                          .saveGeologicalPeriod(value);
                    },
                    context: context,
                  ),
                  const SizedBox(height: Dimens.marginStandard),
                  Text(appLocaleUtils.translate('new_find.find_description')),
                  TextFormField(
                    maxLength: _findDescriptionMaxLength,
                    minLines: _findDescriptionMinLines,
                    maxLines: _findDescriptionMaxLines,
                    validator: _getFormFieldValidator(appLocaleUtils),
                    controller: BlocProvider.of<NewFindCubit>(context)
                        .findDescriptionController,
                  ),
                  const SizedBox(height: Dimens.marginStandard),
                  Text(appLocaleUtils.translate('new_find.discovery_place')),
                  const SizedBox(height: Dimens.marginStandard),
                  _getMyLocationFabWidget(context),
                  const SizedBox(height: Dimens.marginSmall),
                  TextFormField(
                    maxLength: _discoveryPlaceMaxLength,
                    minLines: _discoveryPlaceLines,
                    maxLines: _discoveryPlaceLines,
                    validator: _getFormFieldValidator(appLocaleUtils),
                    controller: BlocProvider.of<NewFindCubit>(context)
                        .discoveryPlaceController,
                  ),
                  const SizedBox(height: Dimens.marginStandard),
                  Text(appLocaleUtils.translate('new_find.discovery_date')),
                  _getDatePickerWidget(context),
                  const SizedBox(height: Dimens.marginDouble),
                  _getSaveFindWidget(
                    context: context,
                    appLocaleUtils: appLocaleUtils,
                    state: state,
                  ),
                ],
              );
            },
            listener: (BuildContext context, NewFindState state) {
              if (state is FindSavingState && !state.savingInProgress) {
                Navigator.pop(context);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _getMyLocationFabWidget(
    BuildContext context,
  ) {
    return Center(
      child: FloatingActionButton(
        child: const Icon(Icons.my_location),
        onPressed: () {
          BlocProvider.of<NewFindCubit>(context).determineUserPosition(context);
        },
      ),
    );
  }

  Widget _getPhotoWidget(
    String photoPath,
  ) {
    return Container(
      height: 250,
      margin: const EdgeInsets.only(top: Dimens.marginStandard),
      alignment: Alignment.center,
      child: Image.file(
        File(photoPath),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _getDropdownWidget({
    required String keyValue,
    required List<String> data,
    required Function(String) valueChangeCallback,
    required BuildContext context,
  }) {
    return Center(
      child: DropdownWidget(
        key: Key(keyValue),
        data: data,
        valueChangeCallback: (String value) => valueChangeCallback(value),
      ),
    );
  }

  FormFieldValidator<String> _getFormFieldValidator(
    AppLocaleUtils appLocaleUtils,
  ) {
    return (value) {
      if (value == null || value.isEmpty) {
        return appLocaleUtils.translate('form.required_field');
      }
      return null;
    };
  }

  Widget _getCameraFabWidget(
    BuildContext context,
  ) {
    return Center(
      child: FloatingActionButton(
        child: const Icon(Icons.photo_camera),
        onPressed: () => _openCamera(context),
      ),
    );
  }

  Widget _getDatePickerWidget(
    BuildContext context,
  ) {
    return Center(
      child: SizedBox(
        width: 300,
        height: 400,
        child: DatePicker(
          minDate: DateTime(2024, 1, 1),
          maxDate: DateTime(2100, 1, 1),
          onDateSelected: (dateTime) {
            BlocProvider.of<NewFindCubit>(context)
                .saveDiscoveryDate(dateTime.toIso8601String());
            // Handle selected date
          },
        ),
      ),
    );
  }

  Widget _getSaveFindWidget({
    required BuildContext context,
    required AppLocaleUtils appLocaleUtils,
    required NewFindState state,
  }) {
    if (state is FindSavingState && state.savingInProgress) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return ElevatedButton(
      onPressed: () {
        if (!BlocProvider.of<NewFindCubit>(context).isPhotoSaved()) {
          _toastUtils.showToast('new_find.photo_required', context);
          return;
        }
        if (formKey.currentState?.validate() == true) {
          BlocProvider.of<NewFindCubit>(context).saveFind(context);
        }
      },
      child: Text(
        appLocaleUtils.translate('new_find.save_find'),
      ),
    );
  }

  void _openCamera(
    BuildContext context,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraWidget(),
      ),
    ).then((photoFile) {
      if (photoFile is XFile) {
        BlocProvider.of<NewFindCubit>(context).savePhoto(photoFile);
      }
    });
  }
}
