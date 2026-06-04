import 'package:equatable/equatable.dart';
import '../../../domain/model/favourite_character.dart';

class FavouriteState extends Equatable {
  final List<FavouriteCharacter> chars;
  final bool isLoading;
  final bool isError;

  const FavouriteState({
    required this.chars,
    required this.isLoading,
    required this.isError,
  });

  FavouriteState copyWith({
    List<FavouriteCharacter>? chars,
    bool? isLoading,
    bool? isError,
  }) => FavouriteState(
    chars: chars ?? this.chars,
    isLoading: isLoading ?? this.isLoading,
    isError: isError ?? this.isError,
  );

  @override
  List<Object?> get props => [
    chars,
    isLoading,
    isError,
  ];
}