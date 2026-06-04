import 'package:dio/dio.dart';
import 'package:disney_characters/my_app.dart';
import 'package:disney_characters/domain/repository/character_repository.dart';
import 'package:disney_characters/data/repository/network_character_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/api/character_api_client.dart';
import 'data/api/favourite_api_client.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final characterDio = Dio(BaseOptions(baseUrl: 'https://api.disneyapi.dev'));
  characterDio.interceptors.add(
    LogInterceptor(
      responseBody: true,
      requestBody: true,
      requestHeader: true,
      responseHeader: true,
      request: true,
    ),
  );
  final characterApiClient = CharacterApiClient(characterDio);
  const apiKey = String.fromEnvironment("apiKey");
  final favouriteDio = Dio(
    BaseOptions(
      baseUrl: 'https://api.restful-api.dev/collections/favourites',
      headers: {
        'x-api-key': apiKey,
      },
    ),
  );
  favouriteDio.interceptors.add(
    LogInterceptor(
      responseBody: true,
      requestBody: true,
      requestHeader: true,
      responseHeader: true,
      request: true,
    ),
  );
  final favouriteApiClient = FavouriteApiClient(favouriteDio);

  final networkCharacterRepository = NetworkCharacterRepository(
    characterApiClient: characterApiClient,
    favouriteApiClient: favouriteApiClient,
  );
  final characterRepositoryProvider = RepositoryProvider<CharacterRepository>(
    create: (context) => networkCharacterRepository,
  );

  runApp(
    MultiRepositoryProvider(
      providers: [characterRepositoryProvider],
      child: const MyApp(),
    ),
  );
}
