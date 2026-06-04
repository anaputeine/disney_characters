import 'package:disney_characters/repository/character_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/favourite/favourite_character.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  late final CharacterRepository _characterRepository;

  @override
  void initState() {
    super.initState();
    _characterRepository = context.read();
  }

  @override
  Widget build(BuildContext context) {
    late Future<List<FavouriteCharacter>>? _favouritesFuture = _characterRepository.getFavouritesCharacters();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("your favourite characters"),
      ),
      body: FutureBuilder<List<FavouriteCharacter>>(
        future: _favouritesFuture,
        builder: (context, snapshot) {
          final connectionState = snapshot.connectionState;
          if (connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final characters =
              snapshot.data ??
              [
                FavouriteCharacter(
                  id: '0',
                  name: "You have no favourites!",
                  imageUrl: "https://i.pinimg.com/236x/ce/1d/01/ce1d01b332e2672581c89b3f5734b6c3.jpg",
                ),
              ];
          return ListView.builder(
            itemBuilder: (context, index) {
              final character = characters[index];
              return Dismissible(
                key: ValueKey(character.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 24),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                onDismissed: (_) async {
                  await _characterRepository.removeFavourite(character.id);

                  setState(() {});
                },
                child: GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      Image.network(
                        character.imageUrl,
                        width: 400,
                        height: 200,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.network(
                            'https://i.pinimg.com/736x/d7/18/3f/d7183f72078df410f83279c1b7bbc191.jpg',
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      Text(character.name),
                    ],
                  ),
                ),
              );
            },
            itemCount: characters.length,
          );
        },
      ),
    );
  }
}
