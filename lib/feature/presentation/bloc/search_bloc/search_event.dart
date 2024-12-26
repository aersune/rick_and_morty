
import 'package:equatable/equatable.dart';

abstract class PersonSearchEvent extends Equatable {
  const PersonSearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchPersons extends PersonSearchEvent {
  final String personQuery;

  const SearchPersons({required this.personQuery});
}

class PersonSearchLoadingEvent extends PersonSearchEvent {
  final String personQuery;

  const PersonSearchLoadingEvent({required this.personQuery});
}

class SearchPersonLoadMore extends PersonSearchEvent {

}