import 'package:flutter/material.dart';
import 'package:psc_learner/core/constants/colors.dart';
import 'package:psc_learner/core/constants/text_style.dart';

class QusCountingSelectingCards extends StatelessWidget {
  final String durationCount;
  const QusCountingSelectingCards({super.key, required this.durationCount});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(222, 79, 95, 184),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        width: 67,
        height: 43,
        child: Center(
          child: Text(
            durationCount,
            style: KtextStyle.normaltext.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
