import 'package:json_annotation/json_annotation.dart';

part 'rooms_dto.g.dart';

@JsonSerializable()
class RoomsDto {
  @JsonKey(name: 'name')
  final String? nazwa;

  RoomsDto({
    this.nazwa,
  });

  factory RoomsDto.fromJson(Map<String, dynamic> json) =>
      _$RoomsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RoomsDtoToJson(this);
}
