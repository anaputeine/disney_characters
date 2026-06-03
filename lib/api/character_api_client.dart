import 'package:dio/dio.dart';
import 'package:disney_characters/model/detail/detail_character_response.dart';
import 'package:disney_characters/model/list/list_character_response.dart';

class CharacterApiClient {
  final Dio _dio;

  CharacterApiClient(this._dio);

  Future<ListCharacterResponse> getAllCharacters() async {
    final response = await _dio.get(
      '/character',
    );
    return ListCharacterResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Future<DetailCharacterResponse> getOneCharacter(String id) async {
    final response = await _dio.get(
      '/character/$id',
    );
    return DetailCharacterResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Future<ListCharacterResponse> getTheseCharacters(
      List<String> ids,
      ) async {
    if (ids.isEmpty) {
      return ListCharacterResponse(
        data: [],
      );
    }

    final query = ids.skip(1).fold(
      'id=${ids.first}',
          (previous, value) => '$previous&id=$value',
    );

    final response = await _dio.get(
      '/character?$query',
    );

    return ListCharacterResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}
