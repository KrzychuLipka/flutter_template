import 'package:flutter_template/data/model/map_position.dart';

class SearchItem {
  final String id;
  final String title;
  final String subTitle;
  final MapPosition mapPosition;

  SearchItem({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.mapPosition,
  });
}
