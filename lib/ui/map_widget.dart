import 'package:arcgis_maps/arcgis_maps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/bloc/map_bloc/map_bloc.dart';
import 'package:flutter_template/common/utils/toast_utils.dart';
import 'package:get_it/get_it.dart';

class MapWidget extends StatelessWidget {
  final ToastUtils _toastUtils = GetIt.instance.get<ToastUtils>();

  MapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapBloc, MapState>(
      listener: (context, state) {
        if (state is ErrorState) {
          _toastUtils.showToast(state.msgKey, context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: _map(context),
          // floatingActionButton: _layersButtons(context),
        );
      },
    );
  }

  Widget _map(
    BuildContext context,
  ) {
    final bloc = context.read<MapBloc>();
    return ArcGISMapView(
      controllerProvider: () => bloc.mapViewController,
      onMapViewReady: () {
        bloc.setUpMap();
      },
    );
  }
}
