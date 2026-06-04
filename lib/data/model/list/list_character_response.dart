import 'package:disney_characters/domain/model/list_character.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_character_response.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class ListCharacterResponse extends Equatable {
  final List<Item> data;

  const ListCharacterResponse({required this.data});

  factory ListCharacterResponse.fromJson(Map<String, dynamic> json) => _$ListCharacterResponseFromJson(json);

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

  ListCharacter toListCharacter() {
    return ListCharacter(
      id: id.toString(),
      name: name ?? 'no name',
      imageUrl: imageUrl ?? 'https://i.pinimg.com/736x/d7/18/3f/d7183f72078df410f83279c1b7bbc191.jpg',
    );
  }

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  @override
  List<Object?> get props => [id, name, imageUrl];
}