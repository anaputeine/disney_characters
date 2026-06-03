import 'package:dio/dio.dart';
import 'package:disney_characters/my_app.dart';
import 'package:disney_characters/repository/character_repository.dart';
import 'package:disney_characters/repository/network_character_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'api/character_api_client.dart';
import 'api/favourite_api_client.dart';

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

  final favouriteDio = Dio(
    BaseOptions(
      baseUrl: 'https://api.restful-api.dev/collections/favourites',
      headers: {
        'x-api-key': '135abbe8-a69a-48c9-872b-ae4f0c56c0cd',
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
