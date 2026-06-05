import 'package:disney_characters/presentation/detail/bloc/detail_cubit.dart';
import 'package:disney_characters/presentation/detail/bloc/detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../l10n/app_localizations.dart';

class CharacterDetailPage extends StatefulWidget {
  const CharacterDetailPage({super.key});

  @override
  State<CharacterDetailPage> createState() => _CharacterDetailPageState();

  static Widget withCubit({
    required String id,
  }) => BlocProvider(
    create: (context) => DetailCubit(
      id: id,
      characterRepository: context.read(),
    )..loadDetail(),
    child: const CharacterDetailPage(),
  );
}

class _CharacterDetailPageState extends State<CharacterDetailPage> {
  late final DetailCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailCubit, DetailState>(
      builder: (context, state) {
        Widget? child;
        if (state.isLoading) {
          child = const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.isError) {
          child = Center(
            child: Text(AppLocalizations.of(context)!.failedToLoad),
          );
        } else {
          final character = state.char;
          final isFavourite = state.isFavourite;
          child = Scaffold(
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
                _HorizontalStringList(title: AppLocalizations.of(context)!.films, items: character.films),
                SizedBox(height: 16),
                _HorizontalStringList(title: AppLocalizations.of(context)!.shortFilms, items: character.shortFilms),
                SizedBox(height: 16),
                _HorizontalStringList(title: AppLocalizations.of(context)!.tvShows, items: character.tvShows),
                SizedBox(height: 16),
                _HorizontalStringList(title: AppLocalizations.of(context)!.videoGames, items: character.videoGames),
                SizedBox(height: 16),
                _HorizontalStringList(title: AppLocalizations.of(context)!.parkAttractions, items: character.parkAttractions),
                SizedBox(height: 16),
                _HorizontalStringList(title: AppLocalizations.of(context)!.allies, items: character.allies),
                SizedBox(height: 16),
                _HorizontalStringList(title: AppLocalizations.of(context)!.enemies, items: character.enemies),
                SizedBox(height: 32),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _cubit.toggleFavourite();
              },
              child: Icon(
                isFavourite ? Icons.favorite : Icons.favorite_border,
              ),
            ),
          );
        }
        return child;
      },
    );
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
