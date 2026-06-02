import 'package:equatable/equatable.dart';

class DetailCharacter extends Equatable {
  final int id;
  final List<String> films;
  final List<String> shortFilms;
  final List<String> tvShows;
  final List<String> videoGames;
  final List<String> parkAttractions;
  final List<String> allies;
  final List<String> enemies;
  final String name;
  final String imageUrl;

  const DetailCharacter({
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

  @override
  List<Object?> get props => [id, name, imageUrl];
}
