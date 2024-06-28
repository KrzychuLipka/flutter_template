import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_template/common/consts/map_consts.dart';
import 'package:flutter_template/common/dimens.dart';
import 'package:flutter_template/cubit/map/map_cubit.dart';
import 'package:flutter_template/cubit/new_find/new_find_cubit.dart';
import 'package:flutter_template/ui/new_find_bottom_sheet.dart';

class MapWidget extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  MapWidget({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      body: _map(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _toggleBaseMapButton(context),
          _reportNewFindButton(context),
        ],
      ),
    );
  }

  Widget _map() {
    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        return FlutterMap(
          options: const MapOptions(
            initialCenter: MapConsts.initialCenter,
            initialZoom: MapConsts.initialZoom,
          ),
          children: [
            TileLayer(
              urlTemplate: state.baseMapsInfo
                  .firstWhere((baseMapInfo) => baseMapInfo.isActive)
                  .urlTemplate,
            ),
          ],
        );
      },
    );
  }

  Widget _toggleBaseMapButton(
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

  Widget _reportNewFindButton(
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
    );
  }
}
