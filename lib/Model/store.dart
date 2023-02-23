import 'package:json_annotation/json_annotation.dart';

part '../data/cardItem.g.dart';

@JsonSerializable()
class StoreList {
  List<Store>? list;

  StoreList({
    required this.list,
  });

  factory StoreList.fromJson(Map<String, dynamic> json) =>
      _$CardListFromJson(json);

  Map<String, dynamic> toJson() => _$CardListToJson(this);
}

@JsonSerializable()
class Store {
  String? image;
  String? name;
  double? score;

  Store({
    required this.image,
    required this.name,
    required this.score,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'gradeK': score,
      'image': image,
    };
  }

  factory Store.fromJson(Map<String, dynamic> json) =>
      _$CardItemFromJson(json);

  Map<String, dynamic> toJson() => _$CardItemToJson(this);
}
