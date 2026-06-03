// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_character_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListCharacterResponse _$ListCharacterResponseFromJson(
  Map<String, dynamic> json,
) => ListCharacterResponse(
  data: (json['data'] as List<dynamic>)
      .map((e) => Item.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
  id: (json['_id'] as num).toInt(),
  name: json['name'] as String?,
  imageUrl: json['imageUrl'] as String?,
);
