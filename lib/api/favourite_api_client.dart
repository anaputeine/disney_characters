import 'package:dio/dio.dart';
import 'package:disney_characters/model/favourite/favourite_object.dart';

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

  Future<void> removeFromFavourite(String apiId) async {
    await _dio.delete('/objects/$apiId');
  }
}
