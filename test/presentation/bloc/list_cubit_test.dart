import 'package:bloc_test/bloc_test.dart';
import 'package:disney_characters/domain/model/favourite_character.dart';
import 'package:disney_characters/domain/model/list_character.dart';
import 'package:disney_characters/presentation/detail/bloc/detail_cubit.dart';
import 'package:disney_characters/presentation/favourite/bloc/favourite_cubit.dart';
import 'package:disney_characters/presentation/list/bloc/list_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'fake_character_repository.dart';

const list = ListCharacter(
  id: "0",
  name: "List Character",
  imageUrl: "List Image",
);

void main() {
  late ListCubit cubit;
  late FakeCharacterRepository fakeCharacterRepository;
  setUp(() {
    fakeCharacterRepository = FakeCharacterRepository();
    cubit = ListCubit(characterRepository: fakeCharacterRepository);
  });
  group('char', () {
    blocTest(
      'is empty when cubit is created',
      build: () => cubit,
      verify: (cubit) {
        expect(cubit.state.chars, isEmpty);
        expect(cubit.state.isError, false);
        expect(cubit.state.isLoading, false);
      },
    );
    blocTest(
      'is filled when loadFavourite is called',
      build: () => cubit,
      act: (cubit) => cubit.loadList(),
      verify: (cubit) {
        expect(cubit.state.chars, isNotEmpty);
        expect(cubit.state.chars.first, list);
        expect(cubit.state.isError, false);
        expect(cubit.state.isLoading, false);
      },
    );
  });
}
