import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_event.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_state.dart';
import 'package:rick_and_morty/feature/presentation/widgets/search_result.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate() : super(searchFieldLabel: 'Search for Characters...');
  final scrollController = ScrollController();

  var allPages = 1;
  var currentPage = 1;

  // void setUpScrollController(BuildContext context,pages) {
  //
  //   scrollController.addListener(() {
  //     if(pages > 1){
  //       if (scrollController.position.atEdge) {
  //         if (scrollController.position.pixels != 0) {
  //           currentPage++;
  //           print('SCROLL FUNCTION WAORKEDD ----- LS');
  //           context.read<PersonSearchBloc>().add(PersonSearchLoadingEvent(personQuery: query));
  //         }
  //       }
  //     }
  //
  //   });
  //
  //
  // }





  final _suggestions = ['Rick', 'Morty', 'Summer', 'Beth', 'Jerry'];


  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: Icon(Icons.arrow_back_ios_outlined),
      tooltip: 'Back',
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    bool isLoading = false;

    void setUpScrollController(BuildContext context) {
      scrollController.addListener(() {
        if(allPages > 1){
          if (scrollController.position.atEdge) {
            if (scrollController.position.pixels != 0) {
              currentPage++;
              print('SCROLL FUNCTION WAORKEDD ----- LS');
              context.read<PersonSearchBloc>().add(PersonSearchLoadingEvent(personQuery: query));
            }
          }
        }

      });
    }
    print(isLoading);




    print('Inside custom search delegate and search query is $query');

    BlocProvider.of<PersonSearchBloc>(context, listen: false).add(SearchPersons(personQuery: query));

    // (allPages > currentPage ) ? setUpScrollController(context) : null;
     setUpScrollController(context) ;

    return BlocBuilder<PersonSearchBloc, PersonSearchState>(builder: (context, state) {
      Set<PersonEntity> persons = {};
      var maxPages = 1;
      if (state is PersonSearchLoadingState && state.isFirstFetch) {
        print('Isfirst loading state');
        return Center(
          child: Center(child: CircularProgressIndicator(),),
        );
      }else if (state is PersonSearchLoadingState) {
        persons = state.oldPersonList.toSet();
        print('Old person loading: ${state.oldPersonList.length}');
        print('person loading: ${persons.length}');
        isLoading = true;
      }

      else if (state is PersonSearchLoaded) {
        persons.clear();
         persons = state.persons.toSet();
         allPages = state.pages;
         maxPages = state.pages;
        isLoading = false;
         print('loaded: length ----${persons.length}');
         print('allpages ----$allPages');

        if(persons.isEmpty){
          return _showErrorText('No Cheracters with that name found');
        }

      }else if(state is PersonSearchError) {
        return _showErrorText(state.message,);
      }else{
        return  Center(child: Icon(Icons.now_wallpaper),);
      }
      return ListView.builder(
          controller: scrollController,
          itemCount: persons.length + (isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < persons.length) {
              return SearchResult(personResult : persons.elementAt(index));
            } else if(currentPage < allPages ){
              Timer(const Duration(milliseconds: 30), () {
                scrollController.jumpTo(scrollController.position.maxScrollExtent);
              });

              return _loadingIndicator();
            }
            return null;


          });


    });
  }
  Widget _showErrorText(String errorMessage) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(8),
        color: Colors.black,
        child: Text(errorMessage,style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),)
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      return Container();
    }
    return ListView.separated(
        padding: EdgeInsets.all(10),
        itemBuilder: (context, index) {
          return Text(
            _suggestions[index],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: _suggestions.length);
  }
  Widget _loadingIndicator() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
