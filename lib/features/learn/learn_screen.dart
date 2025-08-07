import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:psc_learner/core/constants/colors.dart';
import 'package:psc_learner/core/constants/images.dart';
import 'package:psc_learner/core/constants/text_style.dart';
import 'package:psc_learner/core/utils/utils.dart';
import 'package:psc_learner/features/learn/providers/provider_sort.dart';
import 'package:psc_learner/features/learn/widgets/learn_sort_bar.dart';
import 'package:psc_learner/features/learn/widgets/subjects_wiseCards.dart';
import 'package:psc_learner/features/learn/widgets/top_learn_stats.dart';

class LearnScreen extends ConsumerWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLevel = ref.watch(selectedLevelProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgcolor,
        title: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hi user 👋,', style: KtextStyle.subHeadings),
              Text(
                'good luck! Be unique in your own way.',
                style: KtextStyle.subHeadings.copyWith(fontSize: 13),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 10),
          children: [
            const TopLearnStatsGreenor(),
            dividerWidget,
            const LearnSortBar(),
          ..._buildSubjectCards(selectedLevel),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildSubjectCards(String? level) {
    if (level == 'SSLC') {
      return const [
        SubjectsWisecards(
          sub: '|SSLC|',
          image: keralaRenaissance,
          title: 'Kerala Renaissance',
        ),
        SubjectsWisecards(
                    sub: '|SSLC|',

          image: indianHistory,
          title: 'Indian History',
        ),

        SubjectsWisecards(
                    sub: '|SSLC|',

          image: geography,
          title: 'Geography (India & Kerala)',
        ),
        SubjectsWisecards(
                    sub: '|SSLC|',

          image: indianPolity,
          title: 'Indian Polity',
        ),
        SubjectsWisecards(
                    sub: '|SSLC|',

          image: generalScience,
          title: 'General Science',
        ),
        SubjectsWisecards(
                    sub: '|SSLC|',

          image: computerKnowldge,
          title: 'Basic Computer Knowledge',
        ),
        SubjectsWisecards(
                    sub: '|SSLC|',

          image: arithematic,
          title: 'Simple Arithmetic',
        ),
        SubjectsWisecards(
                    sub: '|SSLC|',

          image: english,
          title: 'English Grammar',
        ),
        SubjectsWisecards(
                    sub: '|SSLC|',

          image: malayalam,
          title: 'Malayalam Grammar',
        ),
      ];
    } else if (level == '+2') {
      return const[
        SubjectsWisecards(
                    sub: '|+2|',

          image: keralaRenaissance,
          title: 'Kerala Renaissance',
        ),
        SubjectsWisecards(
                    sub: '|+2|',

          image: indianHistory,
          title:
              'Indian History',
        ),
        SubjectsWisecards(
                    sub: '|+2|',

          image: geography,
          title: 'Indian Geography',
        ),
        SubjectsWisecards(
                    sub: '|+2|',

          image: indianPolity,
          title: 'Indian Polity & Constitution',
        ),
        SubjectsWisecards(
                              sub: '|+2|',

          image: indianEconomy,
          title: 'Indian Economy',
        ),
        SubjectsWisecards(
                              sub: '|+2|',

          image: environmentalScience,
          title: 'Environmental Science',
        ),
        SubjectsWisecards(
                              sub: '|+2|',

          image: generalScience,
          title: 'General Science',
        ),
        SubjectsWisecards(
                              sub: '|+2|',

          image: arithematic,
          title: 'Simple Arithmetic',
        ),
        SubjectsWisecards(
                              sub: '|+2|',

          image: english,
          title: 'English Grammar & Usage ',
        ),
        SubjectsWisecards(
                              sub: '|+2|',

          image: malayalam,
          title: 'Malayalam Grammar',
        ),
        SubjectsWisecards(
                              sub: '|+2|',

          image: computerKnowldge,
          title: 'Computer Awareness',
        ),
      ];
    } else {
      return [

    SubjectsWisecards(image: keralaRenaissance, title: 'kerala Renaissance', sub: '|DEGREE|'),
    SubjectsWisecards(image: modernIndianHistory, title: 'Modern Indian History', sub: '|DEGREE|'),
    SubjectsWisecards(image: indianPolity, title: 'Indian Polity & Constitution', sub: '|DEGREE|'),
    SubjectsWisecards(image: geography, title: 'Indian Geography', sub: '|DEGREE|'),
    SubjectsWisecards(image: indianEconomy, title: 'Indian Economy ', sub: '|DEGREE|'),
    SubjectsWisecards(image: environmentalScience, title: 'Environmental Science & \n Ecology ', sub: '|DEGREE|'),
    SubjectsWisecards(image: generalScience, title: 'General Science ', sub: '|DEGREE|'),
    SubjectsWisecards(image: quantitativeAptitude, title: 'Quantitative Aptitude ', sub: '|DEGREE|'),
        SubjectsWisecards(image: english, title: 'English Grammar \n & Comprehension ', sub: '|DEGREE|'),

    SubjectsWisecards(image: malayalam, title: 'Malayalam', sub: '|DEGREE|'),
    SubjectsWisecards(image: computerKnowldge, title: 'Computer & \nCyber Awareness', sub: '|DEGREE|'),













      ];
    }
  }
}
