import 'package:disney_characters/model/list_character.dart';
import 'package:disney_characters/repository/character_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'character_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final CharacterRepository _characterRepository;
  late final Future<List<ListCharacter>>? _charactersFuture;

  @override
  void initState() {
    super.initState();
    _characterRepository = context.read();
    _charactersFuture = _characterRepository.getAllCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("disney characters"),
      ),
      body: FutureBuilder<List<ListCharacter>>(
        future: _charactersFuture,
        builder: (context, snapshot) {
          print('state=${snapshot.connectionState}');
          print('hasData=${snapshot.hasData}');
          print('hasError=${snapshot.hasError}');
          print('data=${snapshot.data}');
          print('error=${snapshot.error}');
          final connectionState = snapshot.connectionState;
          if (connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final characters =
              snapshot.data ??
              [
                ListCharacter(
                  id: 0,
                  name: "nothing",
                  imageUrl: "https://i.pinimg.com/236x/ce/1d/01/ce1d01b332e2672581c89b3f5734b6c3.jpg",
                ),
              ];
          return ListView.builder(
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
                      height: 200,
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
        },
      ),
    );
  }

  void _showCharacterDetail({
    required BuildContext context,
    required int id,
  }) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CharacterDetailPage(id: id),
    ),
  );
}
