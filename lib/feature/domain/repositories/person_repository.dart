import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/feature/data/models/person_model.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';

abstract class PersonRepository {
  Future<Either<Failure, PersonResultModel>>getAllPersons(int page);
  Future<Either<Failure, PersonResultModel>>searchPerson(String query);
}