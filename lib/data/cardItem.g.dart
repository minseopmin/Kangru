// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cardItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardList _$CardListFromJson(Map<String, dynamic> json) => CardList(
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => CardItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CardListToJson(CardList instance) => <String, dynamic>{
      'list': instance.list,
    };

CardItem _$CardItemFromJson(Map<String, dynamic> json) => CardItem(
      image: json['image'] as String?,
      name: json['name'] as String?,
      score: json['score'] as double?,
    );

Map<String, dynamic> _$CardItemToJson(CardItem instance) => <String, dynamic>{
      'image': instance.image,
      'name': instance.name,
      'score': instance.score,
    };
