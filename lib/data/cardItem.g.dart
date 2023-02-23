// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../Model/store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreList _$CardListFromJson(Map<String, dynamic> json) => StoreList(
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => Store.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CardListToJson(StoreList instance) => <String, dynamic>{
      'list': instance.list,
    };

Store _$CardItemFromJson(Map<String, dynamic> json) => Store(
      image: json['image'] as String?,
      name: json['name'] as String?,
      score: json['score'] as double?,
    );

Map<String, dynamic> _$CardItemToJson(Store instance) => <String, dynamic>{
      'image': instance.image,
      'name': instance.name,
      'score': instance.score,
    };
