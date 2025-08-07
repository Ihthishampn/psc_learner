import 'package:flutter/material.dart';
import 'package:psc_learner/core/constants/colors.dart';
import 'package:psc_learner/core/constants/text_style.dart';
import 'package:psc_learner/core/utils/utils.dart';

class TopLearnStatsGreenor extends StatelessWidget {
  const TopLearnStatsGreenor({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQueryValues(context);
    return Center(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: mq.width * 0.05),
        height: mq.height * 0.1,
        decoration: BoxDecoration(
          color: bgcolor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //  for book mark the qus learner,half learned,not leanrned
            iconsWidget(
              Icon(Icons.task_alt),
              const Color.fromARGB(255, 70, 150, 73),
              () {},
              'completed',
            ),
            iconsWidget(
              Icon(Icons.error_outline),
              const Color.fromARGB(255, 214, 199, 64),
              () {},
              'need improvment',
            ),
            iconsWidget(
              Icon(Icons.highlight_off),
              const Color.fromARGB(255, 202, 73, 63),
              () {},
              'crush it',
            ),
          ],
        ),
      ),
    );
  }

  Widget iconsWidget(
    Icon icon,
    Color color,
    VoidCallback onclick,
    String text,
  ) {
    return Column(
      children: [
        IconButton(onPressed: onclick, icon: icon, iconSize: 38, color: color),
        Text(
          text,
          style: KtextStyle.normaltext.copyWith(fontSize: 10, color: color),
        ),
      ],
    );
  }
}
