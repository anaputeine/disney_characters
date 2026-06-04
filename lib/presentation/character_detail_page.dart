import 'package:disney_characters/domain/repository/character_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/model/detail_character.dart';

class CharacterDetailPage extends StatefulWidget {
  final String id;

  const CharacterDetailPage({super.key, required this.id});

  @override
  State<CharacterDetailPage> createState() => _CharacterDetailPageState();
}

class _CharacterDetailPageState extends State<CharacterDetailPage> {
  late final CharacterRepository _characterRepository;
  late final Future<DetailCharacter>? _character;
  late bool _isFavourite;

  @override
  void initState() {
    super.initState();
    _characterRepository = context.read();
    _character = _characterRepository.getOneCharacter(widget.id);
    _setIsFavourite();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DetailCharacter>(
      future: _character,
      builder: (context, snapshot) {
        final connectionState = snapshot.connectionState;
        if (connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final character =
            snapshot.data ??
            DetailCharacter(
              id: '0',
              films: [],
              shortFilms: [],
              tvShows: [],
              videoGames: [],
              parkAttractions: [],
              allies: [],
              enemies: [],
              name: "nothing was found",
              imageUrl: "https://i.pinimg.com/736x/d7/18/3f/d7183f72078df410f83279c1b7bbc191.jpg",
            );
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(
              character.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: ListView(
            padding: .all(12),
            children: [
              SizedBox(height: 16),
              Image.network(
                character.imageUrl,
                width: 400,
                height: 300,
                fit: .cover,

                errorBuilder: (context, error, stackTrace) {
                  return Image.network(
                    'https://i.pinimg.com/736x/d7/18/3f/d7183f72078df410f83279c1b7bbc191.jpg',
                  );
                },
              ),
              SizedBox(height: 16),
              _HorizontalStringList(title: "Films", items: character.films),
              SizedBox(height: 16),
              _HorizontalStringList(title: "Short Films", items: character.shortFilms),
              SizedBox(height: 16),
              _HorizontalStringList(title: "TvShows", items: character.tvShows),
              SizedBox(height: 16),
              _HorizontalStringList(title: "Video Games", items: character.videoGames),
              SizedBox(height: 16),
              _HorizontalStringList(title: "Park Attractions", items: character.parkAttractions),
              SizedBox(height: 16),
              _HorizontalStringList(title: "Allies", items: character.allies),
              SizedBox(height: 16),
              _HorizontalStringList(title: "Enemies", items: character.enemies),
              SizedBox(height: 32),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              if (_isFavourite) {
                await _characterRepository.removeFavourite(widget.id);
              } else {
                await _characterRepository.addFavourite(widget.id);
              }

              setState(() {
                _isFavourite = !_isFavourite;
              });
            },
            child: Icon(
              _isFavourite ? Icons.favorite : Icons.favorite_border,
            ),
          ),
        );
      },
    );
  }

  Future<void> _setIsFavourite() async {
    final value = await _characterRepository.checkFavourite(
      widget.id,
    );

    setState(() {
      _isFavourite = value;
    });
  }
}

class _HorizontalStringList extends StatelessWidget {
  final String title;
  final List<String> items;

  const _HorizontalStringList({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 60,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(
                  items[index],
                  style: const TextStyle(fontSize: 14),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
