import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/core/usecases/usecases.dart';
import 'package:rick_and_morty/feature/data/models/person_model.dart';
import 'package:rick_and_morty/feature/domain/repositories/person_repository.dart';

class SearchPerson extends Usecase<PersonResultModel, SearchPersonParams> {
  final PersonRepository personRepository;
  SearchPerson(this.personRepository);


  @override
  Future<Either<Failure, PersonResultModel>> call(SearchPersonParams params) async {
    final result = await personRepository.searchPerson(params.query,params.page);
    return result.map((personResult) => personResult);
  }
}

class SearchPersonParams extends Equatable {
  final String query;
  final int page;
  const SearchPersonParams({required this.query, this.page = 1});

  @override
  List<Object?> get props => [query];
}
