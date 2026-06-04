import 'package:disney_characters/model/detail/detail_character.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'detail_character_response.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class DetailCharacterResponse extends Equatable {
  final Item data;

  const DetailCharacterResponse({required this.data});

  factory DetailCharacterResponse.fromJson(Map<String, dynamic> json) => _$DetailCharacterResponseFromJson(json);

  @override
  List<Object?> get props => [data];
}

@JsonSerializable(explicitToJson: true, createToJson: false)
class Item extends Equatable {
  @JsonKey(name: '_id')
  final int id;
  final List<String>? films;
  final List<String>? shortFilms;
  final List<String>? tvShows;
  final List<String>? videoGames;
  final List<String>? parkAttractions;
  final List<String>? allies;
  final List<String>? enemies;
  final String? name;
  final String? imageUrl;

  const Item({
    required this.id,
    required this.films,
    required this.shortFilms,
    required this.tvShows,
    required this.videoGames,
    required this.parkAttractions,
    required this.allies,
    required this.enemies,
    required this.name,
    required this.imageUrl,
  });

  DetailCharacter toDetailCharacter() {
    return DetailCharacter(
      id: id.toString(),
      films: films ?? [],
      shortFilms: shortFilms ?? [],
      tvShows: tvShows ?? [],
      videoGames: videoGames ?? [],
      parkAttractions: parkAttractions ?? [],
      allies: allies ?? [],
      enemies: enemies ?? [],
      name: name ?? "no name",
      imageUrl: imageUrl ?? 'https://i.pinimg.com/736x/d7/18/3f/d7183f72078df410f83279c1b7bbc191.jpg',
    );
  }

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  @override
  List<Object?> get props => [
    id,
    films,
    shortFilms,
    tvShows,
    videoGames,
    parkAttractions,
    allies,
    enemies,
    name,
    imageUrl,
  ];
}
