
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/feature/domain/usecases/search_person.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_event.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_state.dart';

import '../../../domain/entities/person_entity.dart';

class PersonSearchBloc extends Bloc<PersonSearchEvent, PersonSearchState> {
  final SearchPerson searchPerson;
  Set<PersonEntity> oldPerson =  {};
  var page = 1;
  var allPages = 1;

  PersonSearchBloc({required this.searchPerson}) : super(PersonEmpty()) {




    on<PersonSearchLoadingEvent>((event, emit) async{


      final failureOrPerson = await searchPerson(SearchPersonParams(query: event.personQuery, page: page));

      failureOrPerson.fold(
              (failure) => emit(PersonSearchError(message: _mapFailureToMessage(failure))),
              (person) {

            if (page < person.pages ) page++ ;
            oldPerson.addAll(person.personModel);
            allPages = person.pages;


            emit(PersonSearchLoadingState(oldPersonList: oldPerson.toList(), isFirstFetch: page == 1 ));

            // emit(PersonSearchLoaded(persons: person.personModel, pages: person.pages));

            print('Search max pages: --- ${person.pages}');
            print('Search Old person Length: --- ${oldPerson.length}');
            print('Search current pages: --- $page');
          }
      );
    });

    on<SearchPersons>((event, emit) async {
      page = 1;
      oldPerson.clear();
      emit(PersonSearchLoadingState(oldPersonList: oldPerson.toList(), isFirstFetch: page == 1 ));

      final failureOrPerson = await searchPerson(SearchPersonParams(query: event.personQuery, page: page));

      failureOrPerson.fold(
              (failure) => emit(PersonSearchError(message: _mapFailureToMessage(failure))),
              (person) {
                oldPerson.addAll(person.personModel);
                allPages = person.pages;
                emit(PersonSearchLoaded(persons: person.personModel, pages: person.pages));

              }
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