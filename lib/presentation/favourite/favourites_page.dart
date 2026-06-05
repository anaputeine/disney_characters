import 'package:disney_characters/presentation/favourite/bloc/favourite_cubit.dart';
import 'package:disney_characters/presentation/favourite/bloc/favourite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../l10n/app_localizations.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();

  static Widget withCubit() => BlocProvider(
    create: (context) => FavouriteCubit(
      characterRepository: context.read(),
    )..loadFavourite(),
    child: const FavouritesPage(),
  );
}

class _FavouritesPageState extends State<FavouritesPage> {
  late final FavouriteCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteCubit, FavouriteState>(
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
          final characters = state.chars;
          child = ListView.builder(
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
                  await _cubit.removeFavourite(character.id);
                },
                child: GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      Image.network(
                        character.imageUrl,
                        width: 400,
                        height: 268,
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
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(AppLocalizations.of(context)!.yourFavouriteCharacters),
          ),
          body: child,
        );
      },
    );
  }
}
