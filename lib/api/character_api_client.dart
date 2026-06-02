import 'package:dio/dio.dart';
import 'package:disney_characters/model/detail_character_response.dart';
import 'package:disney_characters/model/list_character_response.dart';

class CharacterApiClient {
  final Dio _dio;

  CharacterApiClient(this._dio);

  Future<ListCharacterResponse> getAllCharacters() async {
    final response = await _dio.get(
      '/character',
    );
    return ListCharacterResponse.fromJson(
        response.data as Map<String, dynamic>);
  }

  Future<DetailCharacterResponse> getOneCharacter(int id) async {
    final response = await _dio.get(
      '/character/$id',
    );
    return DetailCharacterResponse.fromJson(
        response.data as Map<String, dynamic>);
  }
}