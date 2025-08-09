import 'package:flutter/material.dart';
import 'package:psc_learner/core/constants/text_style.dart';

class DurationselctingCard extends StatelessWidget {
  final String durationCount;
  const DurationselctingCard({super.key, required this.durationCount});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        width: 67,
        height: 43,
        child: Center(
          child: Text(
            durationCount,
            style: KtextStyle.normaltext.copyWith(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
