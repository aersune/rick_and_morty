import 'package:flutter/material.dart';
import 'package:rick_and_morty/common/app_colors.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty/feature/presentation/pages/person_detail_screen.dart';
import 'package:rick_and_morty/feature/presentation/widgets/person_cache_image.dart';


class SearchResult extends StatelessWidget {
  final PersonEntity personResult;
  const SearchResult({super.key, required this.personResult});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> PersonDetailScreen(person: personResult)));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,bottom: 5),
        child: Card(
          color: AppColors.cellBackground,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),
          elevation: 2.0,
          child: Row(
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: PersonCacheImage(imageUrl: personResult.image, ),
              ),
              Expanded(
                child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(personResult.name, style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(personResult.location.name, style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
