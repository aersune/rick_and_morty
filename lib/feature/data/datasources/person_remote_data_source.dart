import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rick_and_morty/core/error/exeption.dart';
import 'package:rick_and_morty/feature/data/models/person_model.dart';

abstract class PersonRemoteDataSource {
  Future<PersonResultModel> getAllPersons(int page);

  Future<PersonResultModel> searchPerson(String query,int page);
}

class PersonRemoteDataSourceImpl implements PersonRemoteDataSource {
  final http.Client client;

  PersonRemoteDataSourceImpl({required this.client});

  @override
  Future<PersonResultModel> getAllPersons(int page) => _getPersonFromUrl('https://rickandmortyapi.com/api/character/?page=$page');

  @override
  Future<PersonResultModel> searchPerson(String query, int page) => _getPersonFromUrl('https://rickandmortyapi.com/api/character/?page=$page&name=$query');




  Future<PersonResultModel> _getPersonFromUrl(String url) async{
    print(url);
    final response = await client.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final persons = json.decode(response.body);
      print("Max pages ${persons['info']['pages']}");
      return PersonResultModel(pages: persons['info']['pages'], personModel: (persons['results'] as List)
          .map((person) => PersonModel.fromJson(person))
          .toList());
    } else {
      throw ServerException();
    }
  }
}
