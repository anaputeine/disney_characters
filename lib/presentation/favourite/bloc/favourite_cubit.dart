import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repository/character_repository.dart';
import 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  final CharacterRepository _characterRepository;

  FavouriteCubit({
    required this._characterRepository,
  }) : super(
         const FavouriteState(
           chars: [],
           isLoading: false,
           isError: false,
         ),
       );

  Future<void> loadFavourite() async {
    emit(state.copyWith(isLoading: true));

    try {
      final chars = await _characterRepository.getFavouritesCharacters();

      emit(
        state.copyWith(
          chars: chars,
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

  Future<void> removeFavourite(String id) async {
    await _characterRepository.removeFavourite(id);

    final updatedChars =
    state.chars.where((char) => char.id != id).toList();

    emit(
      state.copyWith(
        chars: updatedChars,
      ),
    );
  }
}
