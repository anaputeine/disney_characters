import 'package:dio/dio.dart';
import 'package:disney_characters/model/favourite/favourite_character.dart';

class FavouriteApiClient {
  final Dio _dio;

  FavouriteApiClient(this._dio);

  Future<String> addToFavourite(String actualId) async {
    final body = FavouriteObject(
      id: actualId,
    );
    final response = await _dio.post('/objects', data: body.toJson(), options: Options(contentType: 'application/json'));
    final faveId = response.data['id'];
    return faveId;
  }

  /*
  Future<List<FavouriteObject>> getFaveCharacters(List<String> faveIds) async {
    if (faveIds.isEmpty) return [];
    final ids = faveIds.skip(1).fold('id=${faveIds.first}', (previousValue, value) => '$previousValue&id=$value');
    final response = await _dio.get('objects?$ids');
    final items = response.data as List<dynamic>;
    final actualIds = items.map((item) => FavouriteObject.fromJson(item));
    return actualIds.toList();
  }
*/
  Future<void> removeFromFavourite(String apiId) async {
    await _dio.delete('/objects/$apiId');
  }
}
