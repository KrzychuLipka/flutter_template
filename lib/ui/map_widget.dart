import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_template/common/consts/map_consts.dart';
import 'package:flutter_template/common/dimens.dart';
import 'package:flutter_template/common/utils/toast_utils.dart';
import 'package:flutter_template/cubit/map/map_cubit.dart';
import 'package:flutter_template/cubit/new_find/new_find_cubit.dart';
import 'package:flutter_template/ui/fossil_search_engine_widget.dart';
import 'package:flutter_template/ui/new_find_bottom_sheet.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ToastUtils _toastUtils = GetIt.instance.get<ToastUtils>();

  MapWidget({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    return BlocConsumer<MapCubit, MapState>(
      builder: (context, state) {
        final Widget body;
        if (state is FossilsDownloadingState) {
          body = _getLoaderWidget();
        } else {
          body = _getBodyWidget(context, state);
        }
        return SafeArea(
          child: body,
        );
      },
      listener: (BuildContext context, MapState state) {
        if (state is ErrorState) {
          _toastUtils.showToast(state.errorMessageKey, context);
        }
      },
    );
  }

  Widget _getLoaderWidget() {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }

  Widget _getBodyWidget(
    BuildContext context,
    MapState state,
  ) {
    return Scaffold(
      body: Stack(
        children: [
          _map(context, state),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              Dimens.marginStandard,
              Dimens.marginStandard,
              Dimens.marginStandard,
              86,
            ),
            child: _getSearchEngineWidget(context, state),
          ),
        ],
      ),
      floatingActionButton: _getButtonsWidget(context),
    );
  }

  Widget _getSearchEngineWidget(
    BuildContext context,
    MapState state,
  ) {
    if (state is FossilsDownloadingState) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return FossilSearchEngineWidget(
      fossils: BlocProvider.of<MapCubit>(context).fossils,
      itemClickCallback: (searchItem) {
        BlocProvider.of<MapCubit>(context).saveMarkerData(searchItem);
      },
      itemNotFoundCallback: () {
        _toastUtils.showToast('search_engine.item_not_found', context);
      },
    );
  }

  Widget _map(
    BuildContext context,
    MapState state,
  ) {
    final markerData = BlocProvider.of<MapCubit>(context).markerData;
    final LatLng initialCenter;
    if (markerData == null) {
      initialCenter = MapConsts.initialCenter;
    } else {
      initialCenter = markerData.position;
    }
    return FlutterMap(
      key: GlobalKey(),
      options: MapOptions(
        initialCenter: initialCenter,
        initialZoom: MapConsts.initialZoom,
      ),
      children: [
        TileLayer(
          urlTemplate: BlocProvider.of<MapCubit>(context)
              .baseMapsInfo
              .firstWhere((baseMapInfo) => baseMapInfo.isActive)
              .urlTemplate,
        ),
        if (markerData != null)
          MarkerLayer(
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
                          Expanded(
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
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              onPressed: () {
                                BlocProvider.of<MapCubit>(context)
                                    .clearMarkerData();
                              },
                              icon: const Icon(Icons.close),
                            ),
                          )
                        ],
                      ),
                      Image.network(
                        markerData.photoURL,
                        width: MapConsts.markerWidth,
                        height: MapConsts.markerWidth,
                        fit: BoxFit.cover,
                      ),
                      Padding(
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
                      ),
                      Padding(
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
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
      ],
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
        child: const Icon(Icons.layers_outlined),
        onPressed: () => BlocProvider.of<MapCubit>(context).toggleBaseMap(),
      ),
    );
  }

  Widget _getReportNewFindButtonWidget(
    BuildContext context,
  ) {
    return FloatingActionButton(
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
