import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/core/usecases/usecases.dart';
import 'package:rick_and_morty/feature/data/models/person_model.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty/feature/domain/repositories/person_repository.dart';

class GetAllPersons extends Usecase<PersonResultModel, PagePersonParams> {
  final PersonRepository personRepository;
  GetAllPersons(this.personRepository);

@override
Future<Either<Failure, PersonResultModel>> call(PagePersonParams params) async {
  final result = await personRepository.getAllPersons(params.page);
  return result.map((personResult) => personResult);
}

}

class PagePersonParams extends Equatable {
  final int page;

  const PagePersonParams({required this.page});

  @override
  List<Object?> get props => [page];
}