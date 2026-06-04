import 'package:equatable/equatable.dart';
import '../../../domain/model/list_character.dart';

class ListState extends Equatable {
  final List<ListCharacter> chars;
  final bool isLoading;
  final bool isError;

  const ListState({
    required this.chars,
    required this.isLoading,
    required this.isError,
  });

  ListState copyWith({
    List<ListCharacter>? chars,
    bool? isLoading,
    bool? isError,
  }) => ListState(
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