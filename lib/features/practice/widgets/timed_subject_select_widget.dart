import 'package:flutter/material.dart';
import 'package:psc_learner/core/constants/text_style.dart';

class TimedSubjectSelectWidget extends StatelessWidget {
  const TimedSubjectSelectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(

            color: const Color.fromARGB(222, 79, 95, 184),
     borderRadius: BorderRadius.circular(10)

            ),
            height: 50,
            width: 330,
            child: Center(
              child: Text(
                'Select Subject',
                style: KtextStyle.subHeadings.copyWith(color:const Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
          ),
        );
  }
}