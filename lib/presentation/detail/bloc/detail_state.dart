import 'package:equatable/equatable.dart';
import '../../../domain/model/detail_character.dart';

class DetailState extends Equatable {
  final DetailCharacter char;
  final bool isLoading;
  final bool isError;
  final bool isFavourite;

  const DetailState({
    required this.char,
    required this.isLoading,
    required this.isError,
    required this.isFavourite,
  });

  DetailState copyWith({
    DetailCharacter? char,
    bool? isLoading,
    bool? isError,
    bool? isFavourite,
  }) => DetailState(
    char: char ?? this.char,
    isLoading: isLoading ?? this.isLoading,
    isError: isError ?? this.isError,
    isFavourite: isFavourite ?? this.isFavourite,
  );

  @override
  List<Object?> get props => [
    char,
    isLoading,
    isError,
    isFavourite,
  ];
}