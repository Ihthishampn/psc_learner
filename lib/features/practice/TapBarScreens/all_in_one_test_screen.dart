import 'package:flutter/material.dart';
import 'package:psc_learner/core/utils/utils.dart';
import 'package:psc_learner/features/practice/widgets/all_in_test_Take_a_look_widget.dart';
import 'package:psc_learner/features/practice/widgets/all_in_test_button.dart';
import 'package:psc_learner/features/practice/widgets/stats_widget.dart';

class AllInOneTestScreen extends StatelessWidget {
  const AllInOneTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQueryValues(context);

    return ListView(
      children: [
        SizedBox(height: mq.height * 0.04),
        AllInTestTakeALookWidget(),
        SizedBox(height: mq.height * 0.03),
        AllInTestButton('Start Test'),
        SizedBox(height: mq.height * 0.03),
        StatsWidget(),
      ],
    );
  }
}
