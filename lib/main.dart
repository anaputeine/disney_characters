import 'package:dio/dio.dart';
import 'package:disney_characters/my_app.dart';
import 'package:disney_characters/repository/character_repository.dart';
import 'package:disney_characters/repository/network_character_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'api/character_api_client.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final dio = Dio(BaseOptions(baseUrl: 'https://api.disneyapi.dev'));
  dio.interceptors.add(
    LogInterceptor(
      responseBody: true,
      requestBody: true,
      requestHeader: true,
      responseHeader: true,
      request: true,
    ),
  );
  final characterApiClient = CharacterApiClient(dio);
  final networkCharacterRepository = NetworkCharacterRepository(characterApiClient);
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
