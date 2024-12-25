import 'package:flutter/material.dart';
import 'package:rick_and_morty/common/app_colors.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty/feature/presentation/widgets/person_cache_image.dart';


class PersonDetailScreen extends StatelessWidget {
  final PersonEntity person;

  const PersonDetailScreen({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text("Character", ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30,),
            Text(person.name, style: TextStyle(fontSize: 28,fontWeight: FontWeight.w700, color: Colors.white),),
            const SizedBox(height: 12,),
            PersonCacheImage(imageUrl: person.image, width: 260, height: 260),
            const SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: person.status == 'Alive' ? Colors.green : Colors.red),
                ),
                const SizedBox(width: 8),
                Text(
                  person.status,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(height: 10,),
            if(person.type.isNotEmpty) ...buildText('Type', person.type),
            ...buildText('Gender', person.gender),
            ...buildText('Number of episodes', person.episode.length.toString()),
            ...buildText('Species', person.species),
            ...buildText('Last known location', person.location.name),
            ...buildText('Origin', person.origin.name),
            ...buildText('Was created', person.created.toString()),

        const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }

  List<Widget> buildText(String text, String value) {
    return [

      Text(text, style: TextStyle(color: AppColors.greyColor),),
      const SizedBox(height: 4,),
      Text(value, style: TextStyle(color: Colors.white),),
      const SizedBox(height: 10,),
    ];
  }



}
