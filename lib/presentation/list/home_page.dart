import 'package:disney_characters/domain/model/list_character.dart';
import 'package:disney_characters/domain/repository/character_repository.dart';
import 'package:disney_characters/presentation/list/bloc/list_cubit.dart';
import 'package:disney_characters/presentation/list/bloc/list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../l10n/app_localizations.dart';
import '../detail/character_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  static Widget withCubit() => BlocProvider(
    create: (context) => ListCubit(
      characterRepository: context.read(),
    )..loadList(),
    child: const HomePage(),
  );
}

class _HomePageState extends State<HomePage> {
  late final ListCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListCubit, ListState>(
      builder: (context, state) {
        Widget? child;
        if (state.isLoading) {
          child = const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.isError) {
          child =  Center(
            child: Text(AppLocalizations.of(context)!.failedToLoad),
          );
        } else {
          final characters = state.chars;
          child = ListView.builder(
            itemBuilder: (context, index) {
              final character = characters[index];
              return GestureDetector(
                onTap: () => _showCharacterDetail(context: context, id: character.id),
                child: Column(
                  children: [
                    SizedBox(height: 24),
                    Image.network(
                      character.imageUrl,
                      width: 400,
                      height: 268,
                      fit: .cover,

                      errorBuilder: (context, error, stackTrace) {
                        return Image.network(
                          'https://i.pinimg.com/736x/d7/18/3f/d7183f72078df410f83279c1b7bbc191.jpg',
                        );
                      },
                    ),
                    SizedBox(height: 16),
                    Text(character.name),
                  ],
                ),
              );
            },
            itemCount: characters.length,
          );
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(AppLocalizations.of(context)!.disneyCharacters),
          ),
          body: child,
        );
      },
    );
  }

  void _showCharacterDetail({
    required BuildContext context,
    required String id,
  }) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CharacterDetailPage.withCubit(id: id),
    ),
  );
}
