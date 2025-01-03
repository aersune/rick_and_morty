import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/error/exeption.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/feature/data/datasources/person_remote_data_source.dart';
import 'package:rick_and_morty/feature/data/models/person_model.dart';
import 'package:rick_and_morty/feature/domain/repositories/person_repository.dart';

import '../../../core/platform/network_info.dart';
import '../datasources/person_local_data_source.dart';

class PersonRepositoryImpl implements PersonRepository {
  final PersonRemoteDataSource remoteDataSource;
  final PersonLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PersonRepositoryImpl({required this.remoteDataSource, required this.localDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, PersonResultModel>> getAllPersons(int page) async {
    return await _getPersonResult(() {
      return remoteDataSource.getAllPersons(page);
    });
  }

  Future<Either<Failure, PersonResultModel>> _getPersonResult(Future<PersonResultModel> Function() getPersons) async {
    if (await networkInfo.isConnected) {
      try {

        final remotePerson = await getPersons();

        localDataSource.personsToCache(remotePerson.personModel);
        return Right(remotePerson);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPerson = await localDataSource.getLastPersonsFromCache();
        return Right(PersonResultModel(personModel: localPerson, pages: 10));
      } on CacheExeption {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, PersonResultModel>> searchPerson(String query, int page) async {
    return await _getPersonResult(() {
      return remoteDataSource.searchPerson(query,page);
    });
  }


  Future<Either<Failure, List<PersonModel>>> _getPersons(Future<List<PersonModel>> Function() getPersons) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePerson = await getPersons();
        localDataSource.personsToCache(remotePerson);
        return Right(remotePerson);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPerson = await localDataSource.getLastPersonsFromCache();
        return Right(localPerson);
      } on CacheExeption {
        return Left(CacheFailure());
      }
    }
  }
}
