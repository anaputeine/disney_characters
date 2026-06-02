// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_character_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailCharacterResponse _$DetailCharacterResponseFromJson(
  Map<String, dynamic> json,
) => DetailCharacterResponse(
  data: Item.fromJson(json['data'] as Map<String, dynamic>),
);

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
  id: (json['_id'] as num).toInt(),
  films: (json['films'] as List<dynamic>?)?.map((e) => e as String).toList(),
  shortFilms: (json['shortFilms'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  tvShows: (json['tvShows'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  videoGames: (json['videoGames'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  parkAttractions: (json['parkAttractions'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  allies: (json['allies'] as List<dynamic>?)?.map((e) => e as String).toList(),
  enemies: (json['enemies'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  name: json['name'] as String?,
  imageUrl: json['imageUrl'] as String?,
);
