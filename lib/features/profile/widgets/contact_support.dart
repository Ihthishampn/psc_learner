import 'package:flutter/material.dart';
import 'package:psc_learner/core/constants/text_style.dart';

class ContactSupport extends StatelessWidget {
  const ContactSupport({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Contact Support', style: KtextStyle.subHeadings),
                Text(
                  'psclearner@gmail.com   clickabek aakk tto',
                  style: KtextStyle.subHeadings.copyWith(
                    fontSize: 18,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          );
  }
}