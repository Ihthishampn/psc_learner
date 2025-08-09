import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:psc_learner/core/constants/text_style.dart';
import 'package:psc_learner/core/utils/utils.dart';
import 'package:psc_learner/features/practice/widgets/durationSelcting_card.dart';
import 'package:psc_learner/features/practice/widgets/qusCountSelctingCards.dart';
import 'package:psc_learner/features/practice/widgets/timed_subject_select_widget.dart';
import 'package:psc_learner/features/profile/providers/provider_sort.dart';

class TimedTestsScreen extends ConsumerWidget {
  const TimedTestsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mq = MediaQueryValues(context);
    final levelproviderget = ref.watch(levelProvider);
    return ListView(
      children: [
        SizedBox(height: mq.height * 0.04),
        TimedSubjectSelectWidget(),
        SizedBox(height: mq.height * 0.036),
        ..._buildWidgetsTimeTest(levelproviderget, context),
      ],
    );
  }

  List<Widget> _buildWidgetsTimeTest(Enum level, BuildContext context) {
    final heightofTwo = SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );

    if (level == Level.sslc) {
      return [
        Column(
          children: [
            Text(
              'Select the duration of per question',
              style: KtextStyle.normaltext.copyWith(fontSize: 15),
            ),
heightofTwo,            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DurationselctingCard(durationCount: '30 s'),
                  DurationselctingCard(durationCount: '1 min'),
                  DurationselctingCard(durationCount: '1.30 min'),
                  DurationselctingCard(durationCount: '2 min'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DurationselctingCard(durationCount: '2.30 min'),
                  DurationselctingCard(durationCount: '3 min'),
                  DurationselctingCard(durationCount: '3.5 min'),
                  DurationselctingCard(durationCount: '4 min'),
                ],
              ),
            ),
heightofTwo,            Text(
              'Select the number of questions',
              style: KtextStyle.normaltext.copyWith(fontSize: 15),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  QusCountingSelectingCards(durationCount: '15 qus'),
                  QusCountingSelectingCards(durationCount: '25 qus'),
                  QusCountingSelectingCards(durationCount: '35 qus'),
                  QusCountingSelectingCards(durationCount: '45 qus'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  QusCountingSelectingCards(durationCount: '65 qus'),
                  QusCountingSelectingCards(durationCount: '75 qus'),
                  QusCountingSelectingCards(durationCount: '85 qus'),
                  QusCountingSelectingCards(durationCount: '100 qus'),
                ],
              ),
            ),
heightofTwo,            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  const Color.fromARGB(222, 68, 93, 127),
                ),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              onPressed: () {},
              child: Text('   START  sslc ', style: KtextStyle.normaltext),
            ),
          ],
        ),
      ];
    } else if (level == Level.plusTwo) {
      return [
        Column(
          children: [
            Text(
              'Select the duration of per question',
              style: KtextStyle.normaltext.copyWith(fontSize: 15),
            ),
heightofTwo,            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DurationselctingCard(durationCount: '30 s'),
                  DurationselctingCard(durationCount: '1 min'),
                  DurationselctingCard(durationCount: '1.30 min'),
                  DurationselctingCard(durationCount: '2 min'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DurationselctingCard(durationCount: '2.30 min'),
                  DurationselctingCard(durationCount: '3 min'),
                  DurationselctingCard(durationCount: '3.5 min'),
                  DurationselctingCard(durationCount: '4 min'),
                ],
              ),
            ),
heightofTwo,            Text(
              'Select the number of questions',
              style: KtextStyle.normaltext.copyWith(fontSize: 15),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  QusCountingSelectingCards(durationCount: '15 qus'),
                  QusCountingSelectingCards(durationCount: '25 qus'),
                  QusCountingSelectingCards(durationCount: '35 qus'),
                  QusCountingSelectingCards(durationCount: '45 qus'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  QusCountingSelectingCards(durationCount: '65 qus'),
                  QusCountingSelectingCards(durationCount: '75 qus'),
                  QusCountingSelectingCards(durationCount: '85 qus'),
                  QusCountingSelectingCards(durationCount: '100 qus'),
                ],
              ),
            ),
heightofTwo,            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  const Color.fromARGB(222, 68, 93, 127),
                ),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              onPressed: () {},
              child: Text('   START  +2 ', style: KtextStyle.normaltext),
            ),
          ],
        ),
      ];
    } else {
      return [
        Column(
          children: [
            Text(
              'Select the duration of per question',
              style: KtextStyle.normaltext.copyWith(fontSize: 15),
            ),
heightofTwo,            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DurationselctingCard(durationCount: '30 s'),
                  DurationselctingCard(durationCount: '1 min'),
                  DurationselctingCard(durationCount: '1.30 min'),
                  DurationselctingCard(durationCount: '2 min'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DurationselctingCard(durationCount: '2.30 min'),
                  DurationselctingCard(durationCount: '3 min'),
                  DurationselctingCard(durationCount: '3.5 min'),
                  DurationselctingCard(durationCount: '4 min'),
                ],
              ),
            ),
heightofTwo,            Text(
              'Select the number of questions',
              style: KtextStyle.normaltext.copyWith(fontSize: 15),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  QusCountingSelectingCards(durationCount: '15 qus'),
                  QusCountingSelectingCards(durationCount: '25 qus'),
                  QusCountingSelectingCards(durationCount: '35 qus'),
                  QusCountingSelectingCards(durationCount: '45 qus'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  QusCountingSelectingCards(durationCount: '65 qus'),
                  QusCountingSelectingCards(durationCount: '75 qus'),
                  QusCountingSelectingCards(durationCount: '85 qus'),
                  QusCountingSelectingCards(durationCount: '100 qus'),
                ],
              ),
            ),
heightofTwo,            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  const Color.fromARGB(222, 68, 93, 127),
                ),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              onPressed: () {},
              child: Text('   START  degree ', style: KtextStyle.normaltext),
            ),
          ],
        ),
      ];
    }
  }
}
