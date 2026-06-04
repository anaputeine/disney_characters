import 'package:bloc_test/bloc_test.dart';
import 'package:disney_characters/domain/model/detail_character.dart';
import 'package:disney_characters/presentation/detail/bloc/detail_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'fake_character_repository.dart';

const detailStart = DetailCharacter(
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
);

const detail = DetailCharacter(
  id: "0",
  films: [],
  shortFilms: [],
  tvShows: [],
  videoGames: [],
  parkAttractions: [],
  allies: [],
  enemies: [],
  name: 'Detail Character',
  imageUrl: "Detail Image",
);

void main() {
  late DetailCubit cubit;
  late FakeCharacterRepository fakeCharacterRepository;
  setUp(() {
    fakeCharacterRepository = FakeCharacterRepository();
    cubit = DetailCubit(characterRepository: fakeCharacterRepository, id: "");
  });
  group('char', () {
    blocTest(
      'is default when cubit is created',
      build: () => cubit,
      verify: (cubit) {
        expect(cubit.state.char, detailStart);
        expect(cubit.state.isError, false);
        expect(cubit.state.isLoading, false);
      },
    );
    blocTest(
      'is filled when loadDetail is called',
      build: () => cubit,
      act: (cubit) => cubit.loadDetail(),
      verify: (cubit) {
        expect(cubit.state.char, detail);
        expect(cubit.state.isError, false);
        expect(cubit.state.isLoading, false);
      },
    );
  });

  group('_isFavourite', () {
    blocTest(
      'is false when cubit is created',
      build: () => cubit,
      verify: (cubit) {
        expect(cubit.state.isFavourite, false);
      },
    );
    blocTest(
      'changes from false to true when toggleFavourite is called',
      build: () => cubit,
      act: (cubit) async {
        await cubit.loadDetail();
        await cubit.toggleFavourite();
      },
      verify: (cubit) {
        expect(cubit.state.isFavourite, true);
      },
    );
    blocTest(
      'changes from false to true when toggleFavourite is called',
      build: () => cubit,
      act: (cubit) async {
        await cubit.loadDetail();
        await cubit.toggleFavourite();
        await cubit.toggleFavourite();
      },
      verify: (cubit) {
        expect(cubit.state.isFavourite, false);
      },
    );
  });
}
