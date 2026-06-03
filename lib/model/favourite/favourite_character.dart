import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favourite_character.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: true)
class FavouriteObject extends Equatable {
  final String id;

  const FavouriteObject({required this.id});

  factory FavouriteObject.fromJson(Map<String, dynamic> json) =>
      _$FavouriteObjectFromJson(json);

  Map<String, dynamic> toJson() => _$FavouriteObjectToJson(this);

  @override
  List<Object?> get props => [id];
}

