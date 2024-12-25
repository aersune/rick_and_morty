
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/feature/domain/usecases/search_person.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_event.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_state.dart';

class PersonSearchBloc extends Bloc<PersonSearchEvent, PersonSearchState> {
  final SearchPerson searchPerson;

  PersonSearchBloc({required this.searchPerson}) : super(PersonEmpty()) {
    on<SearchPersons>((event, emit) async {
      emit(PersonSearchLoading());

      final failureOrPerson = await searchPerson(SearchPersonParams(query: event.personQuery));

      failureOrPerson.fold(
              (failure) => emit(PersonSearchError(message: _mapFailureToMessage(failure))),
              (person) => emit(PersonSearchLoaded(persons: person, pages: 24))
      );
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "SERVER_FAILURE";
      case CacheFailure:
        return "CACHE_FAILURE";
      default:
        return 'Unexpected Error';
    }
  }
}