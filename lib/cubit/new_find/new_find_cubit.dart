import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/common/utils/geo_locator_utils.dart';
import 'package:flutter_template/common/utils/logger.dart';
import 'package:flutter_template/common/utils/toast_utils.dart';
import 'package:flutter_template/data/model/error.dart';
import 'package:flutter_template/data/repository/dto/fossil_dto.dart';
import 'package:flutter_template/data/repository/fossils_repository.dart';
import 'package:flutter_template/data/repository/paleo_repository.dart';
import 'package:get_it/get_it.dart';

part 'new_find_state.dart';

class NewFindCubit extends Cubit<NewFindState> {
  final GeoLocatorUtils _geoLocatorUtils =
      GetIt.instance.get<GeoLocatorUtils>();
  final ToastUtils _toastUtils = GetIt.instance.get<ToastUtils>();
  final FossilsRepository _fossilsRepository =
      GetIt.instance.get<FossilsRepository>();

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

  void determineUserPosition(
    BuildContext context,
  ) {
    _toastUtils.showToast('geo_locator.requesting_location', context);
    _geoLocatorUtils.determineUserPosition().catchError((error) {
      if (error is GeneralError) {
        Logger.d(error.technicalMsg);
        _toastUtils.showToast(error.msgKey, context);
      }
      return error;
    }).then((formattedPosition) {
      _discoveryPlaceController.text = formattedPosition;
    });
  }

  void saveFind(
    BuildContext context,
  ) {
    if (_discoveryDate.trim().isEmpty) {
      _discoveryDate = DateTime.now().toIso8601String();
    }
    final fossilDto = FossilDto(
      photoId: _photoPath,
      fossilType: _fossilType,
      geologicalPeriod: _geologicalPeriod,
      findDescription: _findDescriptionController.text,
      discoveryPlace: _discoveryPlaceController.text,
      discoveryDate: _discoveryDate,
    );
    _fossilsRepository.saveFossil(fossilDto: fossilDto).catchError((error) {
      Logger.d('Failed to save fossil: $error');
      _toastUtils.showToast('new_find.save_error', context);
      return error;
    }).then((result) {
      Logger.d('Fossil saved with id=${result.id}');
      _toastUtils.showToast('new_find.save_success', context);
    });
  }
}
