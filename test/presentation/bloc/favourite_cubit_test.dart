import 'package:bloc_test/bloc_test.dart';
import 'package:disney_characters/domain/model/favourite_character.dart';
import 'package:disney_characters/presentation/favourite/bloc/favourite_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'fake_character_repository.dart';

const favourite = FavouriteCharacter(
  id: "0",
  name: "Favourite Character",
  imageUrl: "Favourite Image",
);

void main() {
  late FavouriteCubit cubit;
  late FakeCharacterRepository fakeCharacterRepository;
  setUp(() {
    fakeCharacterRepository = FakeCharacterRepository();
    cubit = FavouriteCubit(characterRepository: fakeCharacterRepository);
  });
  group('chars', () {
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
      act: (cubit) => cubit.loadFavourite(),
      verify: (cubit) {
        expect(cubit.state.chars, isNotEmpty);
        expect(cubit.state.chars.first, favourite);
        expect(cubit.state.isError, false);
        expect(cubit.state.isLoading, false);
      },
    );
    blocTest(
      'is empty when removeFavourite is called',
      build: () => cubit,
      act: (cubit) async {
        await cubit.loadFavourite();
        await cubit.removeFavourite(favourite.id);
      },
      verify: (cubit) {
        expect(cubit.state.chars, isEmpty);
        expect(cubit.state.isError, false);
        expect(cubit.state.isLoading, false);
      },
    );
  });
}
