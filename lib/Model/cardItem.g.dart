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
      address: json['address'] as String?,
      phoneNumber: json['address'] as String?,
      score: json['score'] as double?,
      gScore: json['gScore'] as double?,
      nScore: json['nScore'] as double?,
      kScore: json['kScore'] as double?,
      longitude: json['longitude'] as double?,
      latitude: json['latitude'] as double?,
    );

Map<String, dynamic> _$CardItemToJson(CardItem instance) => <String, dynamic>{
      'image': instance.image,
      'name': instance.name,
      'address' : instance.address,
      'phoneNumber' : instance.phoneNumber,
      'score': instance.score,
      'gScore': instance.gScore,
      'nScore': instance.nScore,
      'kScore': instance.kScore,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
    };
