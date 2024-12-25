import 'package:flutter/material.dart';
import 'package:rick_and_morty/common/app_colors.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty/feature/presentation/pages/person_detail_screen.dart';
import 'package:rick_and_morty/feature/presentation/widgets/person_cache_image.dart';

class PersonCard extends StatelessWidget {
  final PersonEntity person;

  const PersonCard({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> PersonDetailScreen(person: person)));
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cellBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              child: PersonCacheImage(imageUrl: person.image, width: 177, height: 177),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  person.name,
                  style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: person.status == 'Alive' ? Colors.green : Colors.red),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "${person.status} - ${person.species}",
                        style: TextStyle(color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                  ],
                ),
                const SizedBox(height: 10),
                Text('Last known location:', style: TextStyle(color: AppColors.greyColor),),
                const SizedBox(height: 4),
                Text(person.location.name, style: TextStyle(color: Colors.white),maxLines: 1,overflow: TextOverflow.ellipsis,),
                const SizedBox(height: 10),
                Text('Origin:', style: TextStyle(color: AppColors.greyColor),),
                const SizedBox(height: 4),
                Text(person.origin.name, style: TextStyle(color: Colors.white),maxLines: 1,overflow: TextOverflow.ellipsis,),
                const SizedBox(height: 16),
              ],
            )),
            const SizedBox(width: 10,)
          ],
        ),
      ),
    );
  }
}
