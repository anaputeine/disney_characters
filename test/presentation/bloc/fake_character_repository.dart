import 'package:disney_characters/domain/model/detail_character.dart';
import 'package:disney_characters/domain/model/favourite_character.dart';
import 'package:disney_characters/domain/model/list_character.dart';
import 'package:disney_characters/domain/repository/character_repository.dart';

const detail = DetailCharacter(
  id: "0",
  films: [],
  shortFilms: [],
  tvShows: [],
  videoGames: [],
  parkAttractions: [],
  allies: [],
  enemies: [],
  name: 'Detail Character',
  imageUrl: "Detail Image",
);

const favourite = FavouriteCharacter(
  id: "0",
  name: "Favourite Character",
  imageUrl: "Favourite Image",
);

const list = ListCharacter(
  id: "0",
  name: "List Character",
  imageUrl: "List Image",
);

class FakeCharacterRepository implements CharacterRepository {
  final List<FavouriteCharacter> favourites = [favourite];

  @override
  Future<List<ListCharacter>> getAllCharacters() async {
    return [list];
  }

  @override
  Future<DetailCharacter> getOneCharacter(String id) async {
    return detail;
  }

  @override
  Future<List<FavouriteCharacter>> getFavouritesCharacters() async {
    return favourites;
  }

  @override
  Future<void> addFavourite(String actualId) async {
    favourites.add(
      FavouriteCharacter(
        id: actualId,
        name: favourite.name,
        imageUrl: favourite.imageUrl,
      ),
    );
  }

  @override
  Future<void> removeFavourite(String actualId) async {
    favourites.removeWhere(
      (item) => item.id == actualId,
    );
  }

  @override
  Future<bool> checkFavourite(String actualId) async {
    return favourites.any(
      (item) => item.id == actualId,
    );
  }

  Future<Map<String, String>> _getValues() async {
    final Map<String, String> response = {};
    return response;
  }

  Future<void> _setValues(
    Map<String, String> favourites,
  ) async {}
}
