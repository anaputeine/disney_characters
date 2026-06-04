import 'package:disney_characters/domain/model/favourite_character.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favourite_character_response.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class FavouriteCharacterResponse extends Equatable {
  final Item data;

  const FavouriteCharacterResponse({required this.data});

  factory FavouriteCharacterResponse.fromJson(Map<String, dynamic> json) => _$FavouriteCharacterResponseFromJson(json);

  FavouriteCharacter toFavouriteCharacter() {
    return FavouriteCharacter(
      id: data.id.toString(),
      name: data.name ?? "no name",
      imageUrl: data.imageUrl ?? 'https://i.pinimg.com/736x/d7/18/3f/d7183f72078df410f83279c1b7bbc191.jpg',
    );
  }

  @override
  List<Object?> get props => [data];
}

@JsonSerializable(explicitToJson: true, createToJson: false)
class Item extends Equatable {
  @JsonKey(name: '_id')
  final int id;
  final String? name;
  final String? imageUrl;

  const Item({
    required this.id,
    required this.name,
    required this.imageUrl,
  });


  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  @override
  List<Object?> get props => [
    id,
    name,
    imageUrl,
  ];
}
