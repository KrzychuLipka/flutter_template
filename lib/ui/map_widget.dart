import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_template/common/consts/map_consts.dart';
import 'package:flutter_template/common/dimens.dart';
import 'package:flutter_template/common/utils/toast_utils.dart';
import 'package:flutter_template/cubit/map/map_cubit.dart';
import 'package:flutter_template/cubit/new_find/new_find_cubit.dart';
import 'package:flutter_template/ui/new_find_bottom_sheet.dart';
import 'package:flutter_template/ui/search_engine_widget.dart';
import 'package:get_it/get_it.dart';

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
          _map(context),
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
    return SearchEngineWidget(
      searchItems: BlocProvider.of<MapCubit>(context).searchItems,
      itemClickCallback: (searchItem) {
        // TODO
        _toastUtils.debugToast(searchItem.id);
      },
      itemNotFoundCallback: () {
        _toastUtils.showToast('search_engine.item_not_found', context);
      },
    );
  }

  Widget _map(
    BuildContext context,
  ) {
    return FlutterMap(
      options: const MapOptions(
        initialCenter: MapConsts.initialCenter,
        initialZoom: MapConsts.initialZoom,
      ),
      children: [
        TileLayer(
          urlTemplate: BlocProvider.of<MapCubit>(context)
              .baseMapsInfo
              .firstWhere((baseMapInfo) => baseMapInfo.isActive)
              .urlTemplate,
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
