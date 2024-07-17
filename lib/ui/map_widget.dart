import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geo_app/common/consts/map_consts.dart';
import 'package:geo_app/common/dimens.dart';
import 'package:geo_app/common/utils/logger.dart';
import 'package:geo_app/common/utils/toast_utils.dart';
import 'package:geo_app/cubit/map/map_cubit.dart';
import 'package:geo_app/cubit/new_find/new_find_cubit.dart';
import 'package:geo_app/data/model/error.dart';
import 'package:geo_app/data/model/marker_data.dart';
import 'package:geo_app/ui/fossil_search_engine_widget.dart';
import 'package:geo_app/ui/new_find_bottom_sheet.dart';
import 'package:get_it/get_it.dart';

class MapWidget extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ToastUtils _toastUtils = GetIt.instance.get<ToastUtils>();

  MapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapCubit, MapState>(
      builder: (context, state) => _getBodyWidget(context),
      listener: (BuildContext context, MapState state) {
        Logger.d('Current state: $state');
      },
    );
  }

  Widget _getBodyWidget(
    BuildContext context,
  ) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            _getMapWidget(context),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                Dimens.marginStandard,
                Dimens.marginStandard,
                Dimens.marginStandard,
                86,
              ),
              child: _getSearchEngineWidget(context),
            ),
          ],
        ),
        floatingActionButton: _getButtonsWidget(context),
      ),
    );
  }

  Widget _getSearchEngineWidget(
    BuildContext context,
  ) {
    return StreamBuilder(
        stream: BlocProvider.of<MapCubit>(context).fossilsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError && snapshot.error is GeneralError) {
            final error = snapshot.error as GeneralError;
            Logger.d(error.technicalMsg);
            _toastUtils.showToast(error.msgKey, context);
            return const SizedBox();
          }
          if (!snapshot.hasData) {
            return const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
          final cubit = BlocProvider.of<MapCubit>(context);
          return FossilSearchEngineWidget(
            fossils: snapshot.data ?? [],
            itemClickCallback: (searchItem) {
              cubit.saveMarkerData(searchItem);
            },
            itemNotFoundCallback: () {
              _toastUtils.showToast('search_engine.item_not_found', context);
            },
          );
        });
  }

  Widget _getMapWidget(
    BuildContext context,
  ) {
    final bloc = BlocProvider.of<MapCubit>(context);
    return StreamBuilder(
        stream: bloc.markerDataStream,
        builder: (context, snapshot) {
          final markerData = snapshot.data;
          return FlutterMap(
            key: GlobalKey(),
            options: MapOptions(
              initialCenter: bloc.getMapInitialPoint(),
              initialZoom: MapConsts.initialZoom,
            ),
            children: [
              _getBaseMapLayer(context),
              if (markerData != null)
                _getMarkerWidget(
                  markerData: markerData,
                  context: context,
                ),
            ],
          );
        });
  }

  Widget _getBaseMapLayer(
    BuildContext context,
  ) {
    return StreamBuilder(
      stream: BlocProvider.of<MapCubit>(context).mapUrlTemplateStream,
      initialData: MapConsts.openTopoMapTemplate,
      builder: (context, snapshot) => TileLayer(
        urlTemplate: snapshot.data,
      ),
    );
  }

  Widget _getMarkerWidget({
    required MarkerData markerData,
    required BuildContext context,
  }) {
    return MarkerLayer(
      markers: [
        Marker(
          rotate: true,
          width: MapConsts.markerWidth,
          height: MapConsts.markerHeight,
          point: markerData.position,
          child: Card(
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    _getMarkerRow1Widget(
                      markerData: markerData,
                      context: context,
                    ),
                    _getClearMarkerIconWidget(
                      markerData: markerData,
                      context: context,
                    )
                  ],
                ),
                Image.network(
                  markerData.photoURL,
                  width: MapConsts.markerWidth,
                  height: MapConsts.markerWidth,
                  fit: BoxFit.cover,
                ),
                _getMarkerRow2Widget(
                  markerData: markerData,
                  context: context,
                ),
                _getMarkerRow3Widget(
                  markerData: markerData,
                  context: context,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _getMarkerRow1Widget({
    required MarkerData markerData,
    required BuildContext context,
  }) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          Dimens.marginStandard,
          Dimens.marginStandard,
          0,
          Dimens.marginStandard,
        ),
        child: Text(
          markerData.row1,
          maxLines: 1,
          style: Theme.of(context).textTheme.bodyLarge,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _getClearMarkerIconWidget({
    required MarkerData markerData,
    required BuildContext context,
  }) {
    return Expanded(
      flex: 1,
      child: IconButton(
        onPressed: () {
          BlocProvider.of<MapCubit>(context).clearMarkerData();
        },
        icon: const Icon(Icons.close),
      ),
    );
  }

  Widget _getMarkerRow2Widget({
    required MarkerData markerData,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        Dimens.marginStandard,
        Dimens.marginStandard,
        Dimens.marginStandard,
        Dimens.marginSmall,
      ),
      child: Text(
        textAlign: TextAlign.center,
        markerData.row2,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  Widget _getMarkerRow3Widget({
    required MarkerData markerData,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        Dimens.marginStandard,
        Dimens.marginSmall,
        Dimens.marginStandard,
        Dimens.marginStandard,
      ),
      child: Text(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        markerData.row3,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }

  Widget _getButtonsWidget(
    BuildContext context,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _getToggleBaseMapButtonWidget(context),
        _getReportNewFindButtonWidget(context),
      ],
    );
  }

  Widget _getToggleBaseMapButtonWidget(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: Dimens.marginDouble),
      child: FloatingActionButton(
        heroTag: 'mapTypes',
        child: const Icon(Icons.layers_outlined),
        onPressed: () => BlocProvider.of<MapCubit>(context).toggleBaseMap(),
      ),
    );
  }

  Widget _getReportNewFindButtonWidget(
    BuildContext context,
  ) {
    return FloatingActionButton(
      heroTag: 'addFossil',
      child: const Icon(Icons.add),
      onPressed: () => _showNewFindBottomSheet(context),
    );
  }

  void _showNewFindBottomSheet(
    BuildContext context,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return BlocProvider<NewFindCubit>(
          create: (_) => NewFindCubit(),
          child: NewFindBottomSheet(
            formKey: _formKey,
          ),
        );
      },
    ).whenComplete(() {
      BlocProvider.of<MapCubit>(context).downloadFossils();
    });
  }
}
