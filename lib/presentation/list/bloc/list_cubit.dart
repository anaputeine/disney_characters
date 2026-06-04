import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repository/character_repository.dart';
import 'list_state.dart';

class ListCubit extends Cubit<ListState> {
  final CharacterRepository _characterRepository;

  ListCubit({
    required this._characterRepository,
  }) : super(
         const ListState(
           chars: [],
           isLoading: false,
           isError: false,
         ),
       );

  Future<void> loadList() async {
    emit(state.copyWith(isLoading: true));

    try {
      final chars = await _characterRepository.getAllCharacters();

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
}
