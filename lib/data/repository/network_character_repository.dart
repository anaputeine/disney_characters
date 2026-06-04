import 'package:disney_characters/data/api/favourite_api_client.dart';
import 'package:disney_characters/domain/model/list_character.dart';
import 'package:disney_characters/domain/repository/character_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/character_api_client.dart';
import '../../domain/model/detail_character.dart';
import 'dart:convert';
import '../../domain/model/favourite_character.dart';

class NetworkCharacterRepository implements CharacterRepository {
  final CharacterApiClient _characterApiClient;
  final FavouriteApiClient _favouriteApiClient;

  NetworkCharacterRepository({required this._characterApiClient, required this._favouriteApiClient});

  @override
  Future<List<ListCharacter>> getAllCharacters() async {
    final response = await _characterApiClient.getAllCharacters();
    return response.data.map((item) => item.toListCharacter()).toList();
  }

  @override
  Future<DetailCharacter> getOneCharacter(String id) async {
    final response = await _characterApiClient.getOneCharacter(id);
    return response.data.toDetailCharacter();
  }

  @override
  Future<List<FavouriteCharacter>> getFavouritesCharacters() async {
    final favourites = await _getValues();
    final response = await _characterApiClient.getTheseCharacters(
      favourites.keys.toList(),
    );
    return response.map((item) => item.toFavouriteCharacter()).toList();
  }

  @override
  Future<void> addFavourite(String actualId) async {
    final favourites = await _getValues();

    final faveId = await _favouriteApiClient.addToFavourite(actualId);

    favourites[actualId] = faveId;

    await _setValues(favourites);
  }

  @override
  Future<void> removeFavourite(String actualId) async {
    final favourites = await _getValues();

    final faveId = favourites[actualId];

    if (faveId == null) {
      return;
    }

    await _favouriteApiClient.removeFromFavourite(
      faveId,
    );

    favourites.remove(actualId);

    await _setValues(favourites);
  }

  @override
  Future<bool> checkFavourite(
    String actualId,
  ) async {
    final favourites = await _getValues();

    return favourites.containsKey(actualId);
  }

  Future<Map<String, String>> _getValues() async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = prefs.getString('fave_ids');

    if (jsonString == null) {
      return {};
    }

    return Map<String, String>.from(
      jsonDecode(jsonString),
    );
  }

  Future<void> _setValues(
    Map<String, String> favourites,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      'fave_ids',
      jsonEncode(favourites),
    );
  }
}
