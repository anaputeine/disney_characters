import 'package:disney_characters/domain/model/detail_character.dart';
import 'package:disney_characters/presentation/detail/bloc/detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repository/character_repository.dart';

class DetailCubit extends Cubit<DetailState> {
  final String id;
  final CharacterRepository _characterRepository;

  DetailCubit({
    required this._characterRepository,
    required this.id,
  }) : super(
         const DetailState(
           char: DetailCharacter(
             id: "",
             films: [],
             shortFilms: [],
             tvShows: [],
             videoGames: [],
             parkAttractions: [],
             allies: [],
             enemies: [],
             name: "",
             imageUrl: 'https://i.pinimg.com/736x/d7/18/3f/d7183f72078df410f83279c1b7bbc191.jpg',
           ),
           isLoading: false,
           isError: false,
           isFavourite: false,
         ),
       );

  Future<void> loadDetail() async {
    emit(state.copyWith(isLoading: true));

    try {
      final char = await _characterRepository.getOneCharacter(id);
      final isFavourite = await _characterRepository.checkFavourite(id);

      emit(
        state.copyWith(
          char: char,
          isFavourite: isFavourite,
          isLoading: false,
        ),
      );
    } catch (e, st) {
      print(e);
      print(st);

      emit(
        state.copyWith(
          isError: true,
          isLoading: false,
        ),
      );
    }
  }

  Future<void> toggleFavourite() async {
    if (state.isFavourite) {
      await _characterRepository.removeFavourite(id);
    } else {
      await _characterRepository.addFavourite(id);
    }

    emit(
      state.copyWith(
        isFavourite: !state.isFavourite,
      ),
    );
  }
}
