import 'package:flutter/material.dart';
import 'package:psc_learner/core/constants/colors.dart';
import 'package:psc_learner/core/constants/text_style.dart';

class LearnSortBar extends StatelessWidget {
  const LearnSortBar({super.key});

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'Learn',
          style: KtextStyle.normaltext.copyWith(
            fontSize: 26,
            color: lightWhite,
          ),
        ),
       IconButton(onPressed: (){}, icon: Icon(Icons.local_fire_department,size: 26,color: const Color.fromARGB(255, 168, 94, 89),))
    
      ],
    );
  }
}
