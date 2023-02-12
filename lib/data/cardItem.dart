import 'package:json_annotation/json_annotation.dart';

part 'cardItem.g.dart';

@JsonSerializable()
class CardList {
  List<CardItem>? list;

  CardList({
    required this.list,
  });

  factory CardList.fromJson(Map<String, dynamic> json) =>
      _$CardListFromJson(json);

  Map<String, dynamic> toJson() => _$CardListToJson(this);
}

@JsonSerializable()
class CardItem {
  String? image;
  String? name;
  double? score;
  double? longitude;
  double? latitude;

  CardItem({
    required this.image,
    required this.name,
    required this.score,
    required this.longitude,
    required this.latitude,
  });

  factory CardItem.fromJson(Map<String, dynamic> json) =>
      _$CardItemFromJson(json);

  Map<String, dynamic> toJson() => _$CardItemToJson(this);
}
