import 'package:disney_characters/model/list_character.dart';
import 'package:disney_characters/repository/character_repository.dart';
import '../api/character_api_client.dart';
import '../model/detail_character.dart';

class NetworkCharacterRepository implements CharacterRepository {
  final CharacterApiClient _characterApiClient;

  NetworkCharacterRepository(this._characterApiClient);

  @override
  Future<List<ListCharacter>> getAllCharacters() async {
    final response = await _characterApiClient.getAllCharacters();
    return response.data.map((item) => item.toListCharacter()).toList();
  }

  @override
  Future<DetailCharacter> getOneCharacter(int id) async {
    final response = await _characterApiClient.getOneCharacter(id);
    return response.data.toDetailCharacter();
  }
}
