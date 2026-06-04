// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_character_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavouriteCharacterResponse _$FavouriteCharacterResponseFromJson(
  Map<String, dynamic> json,
) => FavouriteCharacterResponse(
  data: Item.fromJson(json['data'] as Map<String, dynamic>),
);

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
  id: (json['_id'] as num).toInt(),
  name: json['name'] as String?,
  imageUrl: json['imageUrl'] as String?,
);
