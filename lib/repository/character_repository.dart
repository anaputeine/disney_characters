import 'package:disney_characters/model/list_character.dart';
import '../model/detail_character.dart';

abstract class CharacterRepository {

  Future<List<ListCharacter>> getAllCharacters();

  Future<DetailCharacter> getOneCharacter(int id);
}
