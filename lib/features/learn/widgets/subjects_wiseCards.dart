import 'package:flutter/material.dart';
import 'package:psc_learner/core/constants/colors.dart';
import 'package:psc_learner/core/constants/text_style.dart';
import 'package:psc_learner/core/utils/utils.dart';

class SubjectsWisecards extends StatelessWidget {
  final AssetImage image;
  final String title;
  final String sub;
  const SubjectsWisecards({
    super.key,
    required this.image,
    required this.title, required this.sub,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQueryValues(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: KtextStyle.subHeadings),
                Padding(
                  padding: const EdgeInsets.only(right: 13),
                  child: Text(sub, style: KtextStyle.answerStyle),
                ),
              ],
            ),
          ),
          const SizedBox(height: 1),
          Center(
            child: SizedBox(
              height: mq.height * 0.16,
              width: mq.width * 0.93,
              child: Container(
                decoration: BoxDecoration(
                  color: bgcolor,
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(image: image, fit: BoxFit.fitWidth),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



