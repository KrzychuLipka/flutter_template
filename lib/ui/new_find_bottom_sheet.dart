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
                  _getCloseButton(context),
                  const SizedBox(height: Dimens.marginSmall),
                  Text(appLocaleUtils.translate('new_find.photo')),
                  if (state is PhotoTakenState)
                    _getPhotoWidget(state.photoPath),
                  const SizedBox(height: Dimens.marginStandard),
                  _getCameraFabWidget(context),
                  const SizedBox(height: Dimens.marginStandard),
                  _getFossilTypeSelectionWidget(context),
                  const SizedBox(height: Dimens.marginStandard),
                  _getGeologicalPeriodSelectionWidget(context),
                  const SizedBox(height: Dimens.marginStandard),
                  _getFindDescriptionWidget(context),
                  const SizedBox(height: Dimens.marginStandard),
                  _getMyLocationFabWidget(context),
                  const SizedBox(height: Dimens.marginStandard),
                  _getDiscoveryPlaceWidget(context),
                  const SizedBox(height: Dimens.marginStandard),
                  Text(appLocaleUtils.translate('new_find.discovery_date')),
                  _getDatePickerWidget(context),
                  const SizedBox(height: Dimens.marginDouble),
                  _getSaveFindWidget(
                    context: context,
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

  Widget _getFossilTypeSelectionWidget(
    BuildContext context,
  ) {
    return _getSelectionWidget(
      labelKey: 'new_find.fossil_type',
      keyValue: 'fossilTypes',
      data: PaleoRepository.fossilTypes,
      valueChangeCallback: (value) {
        BlocProvider.of<NewFindCubit>(context).saveFossilType(value);
      },
      context: context,
    );
  }

  Widget _getSelectionWidget({
    required String labelKey,
    required String keyValue,
    required List<String> data,
    required Function(String) valueChangeCallback,
    required BuildContext context,
  }) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(AppLocaleUtils.of(context).translate(labelKey)),
        ),
        Expanded(
          flex: 2,
          child: Align(
            alignment: Alignment.centerLeft,
            child: DropdownWidget(
              key: Key(keyValue),
              data: data,
              valueChangeCallback: (String value) => valueChangeCallback(value),
            ),
          ),
        ),
      ],
    );
  }

  Widget _getGeologicalPeriodSelectionWidget(
    BuildContext context,
  ) {
    return _getSelectionWidget(
      labelKey: 'new_find.geological_period',
      keyValue: 'geologicalPeriods',
      data: PaleoRepository.geologicalPeriods,
      valueChangeCallback: (value) {
        BlocProvider.of<NewFindCubit>(context).saveGeologicalPeriod(value);
      },
      context: context,
    );
  }

  Widget _getFindDescriptionWidget(
    BuildContext context,
  ) {
    return _getTextFormFieldWidget(
      labelKey: 'new_find.find_description',
      maxLength: _findDescriptionMaxLength,
      minLines: _findDescriptionMinLines,
      maxLines: _findDescriptionMaxLines,
      textEditingController:
          BlocProvider.of<NewFindCubit>(context).findDescriptionController,
      context: context,
    );
  }

  Widget _getTextFormFieldWidget({
    required String labelKey,
    required int maxLength,
    required int minLines,
    required int maxLines,
    required TextEditingController textEditingController,
    bool readOnly = false,
    required BuildContext context,
  }) {
    AppLocaleUtils appLocaleUtils = AppLocaleUtils.of(context);
    return TextFormField(
      readOnly: readOnly,
      maxLength: maxLength,
      minLines: minLines,
      maxLines: maxLines,
      validator: _getFormFieldValidator(appLocaleUtils),
      controller: textEditingController,
      decoration: InputDecoration(
        label: Text(
          appLocaleUtils.translate(labelKey),
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _getDiscoveryPlaceWidget(
    BuildContext context,
  ) {
    return _getTextFormFieldWidget(
      labelKey: 'new_find.discovery_place',
      maxLength: _discoveryPlaceMaxLength,
      minLines: _discoveryPlaceLines,
      maxLines: _discoveryPlaceLines,
      textEditingController:
          BlocProvider.of<NewFindCubit>(context).discoveryPlaceController,
      readOnly: true,
      context: context,
    );
  }

  Widget _getCloseButton(
    BuildContext context,
  ) {
    return Align(
      alignment: Alignment.centerRight,
      child: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          Navigator.pop(context);
        },
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
      margin: const EdgeInsets.only(top: Dimens.marginSmall),
      alignment: Alignment.center,
      child: Image.file(
        File(photoPath),
        fit: BoxFit.cover,
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
        height: 400,
        child: DatePicker(
          selectedCellDecoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            shape: BoxShape.circle,
          ),
          centerLeadingDate: true,
          enabledCellsTextStyle: const TextStyle(color: Colors.black),
          disabledCellsTextStyle: const TextStyle(color: Colors.black),
          daysOfTheWeekTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: Dimens.fontSizeSmall,
          ),
          leadingDateTextStyle: const TextStyle(color: Colors.black),
          currentDateTextStyle: const TextStyle(color: Colors.black),
          selectedCellTextStyle: const TextStyle(color: Colors.black),
          slidersColor: Colors.black,
          splashColor: Colors.amber,
          highlightColor: Colors.black,
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
        AppLocaleUtils.of(context).translate('new_find.save_find'),
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
