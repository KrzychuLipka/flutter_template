import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_template/common/consts/map_consts.dart';
import 'package:flutter_template/common/dimens.dart';
import 'package:flutter_template/cubit/map/map_cubit.dart';
import 'package:flutter_template/cubit/new_find/new_find_cubit.dart';
import 'package:flutter_template/data/model/search_item.dart';
import 'package:flutter_template/ui/new_find_bottom_sheet.dart';
import 'package:flutter_template/ui/search_engine_widget.dart';

class MapWidget extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  MapWidget({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    return SafeArea(
      child: Scaffold(
        body: _getBodyWidget(),
        floatingActionButton: _getButtonsWidget(context),
      ),
    );
  }

  Widget _getBodyWidget() {
    return Stack(
      children: [
        _map(),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            Dimens.marginStandard,
            Dimens.marginStandard,
            Dimens.marginStandard,
            86,
          ),
          child: SearchEngineWidget(
            searchItems: [
              SearchItem(title: 'Znalezisko 1', subTitle: 'Okres 1'),
              SearchItem(title: 'Znalezisko 2', subTitle: 'Okres 1'),
              SearchItem(title: 'Znalezisko 3', subTitle: 'Okres 1'),
              SearchItem(title: 'Znalezisko 4', subTitle: 'Okres 2'),
              SearchItem(title: 'Znalezisko 5', subTitle: 'Okres 2'),
              SearchItem(title: 'Znalezisko 6', subTitle: 'Okres 1'),
              SearchItem(title: 'Znalezisko 7', subTitle: 'Okres 1'),
              SearchItem(title: 'Znalezisko 8', subTitle: 'Okres 1'),
              SearchItem(title: 'Znalezisko 9', subTitle: 'Okres 2'),
              SearchItem(title: 'Znalezisko 10', subTitle: 'Okres 2'),
              SearchItem(title: 'Znalezisko 11', subTitle: 'Okres 1'),
              SearchItem(title: 'Znalezisko 12', subTitle: 'Okres 1'),
              SearchItem(title: 'Znalezisko 13', subTitle: 'Okres 1'),
              SearchItem(title: 'Znalezisko 14', subTitle: 'Okres 2'),
              SearchItem(title: 'Znalezisko 15', subTitle: 'Okres 2'),
            ],
          ),
        ),
      ],
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
    );
  }
}
