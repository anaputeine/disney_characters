import 'package:disney_characters/model/list/list_character.dart';
import '../model/detail/detail_character.dart';

abstract class CharacterRepository {

  Future<List<ListCharacter>> getAllCharacters();

  Future<DetailCharacter> getOneCharacter(String id);

  //Future<List<ListCharacter>> getFavouritesCharacters();

  Future<void> addFavourite(String actualId);

  Future<void> removeFavourite(String actualId);

  Future<bool> checkFavourite(String actualId);

  Future<Map<String, String>> _getValues();

  Future<void> _setValues(Map<String, String> favourites);
}
