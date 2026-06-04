import 'package:dio/dio.dart';
import 'package:disney_characters/model/detail/detail_character_response.dart';
import 'package:disney_characters/model/list/list_character_response.dart';

import '../model/favourite/favourite_character_response.dart';

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

  Future<List<FavouriteCharacterResponse>> getTheseCharacters(
    List<String> ids,
  ) async {
    return Future.wait(
      ids.map((id) async {
        final response = await _dio.get(
          '/character/$id',
        );
        return FavouriteCharacterResponse.fromJson(
          response.data as Map<String, dynamic>,
        );
      }),
    );
  }
}
