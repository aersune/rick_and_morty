
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';

abstract class PersonSearchState extends Equatable {
  const PersonSearchState();

 @override
  List<Object?> get props => [];
}


class PersonEmpty extends PersonSearchState {}

class PersonSearchLoadingState extends PersonSearchState {
  final List<PersonEntity> oldPersonList;
  final bool isFirstFetch;

  const PersonSearchLoadingState({required this.oldPersonList, this.isFirstFetch = false});

  @override
  List<Object?> get props => [oldPersonList];
}

class PersonSearchLoaded extends PersonSearchState {
   final int pages;
   final List<PersonEntity> persons;

   const PersonSearchLoaded({required this.persons, required this.pages});

   @override
  List<Object?> get props => [persons];
}

class PersonSearchError extends PersonSearchState {
  final String message;
  const PersonSearchError({required this.message});

  @override
  List<Object?> get props => [message];
}