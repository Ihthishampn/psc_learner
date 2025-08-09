import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:psc_learner/core/utils/utils.dart';
import 'package:psc_learner/features/practice/widgets/huntingCardsWidgets.dart';
import 'package:psc_learner/features/profile/providers/provider_sort.dart';

class HuntingScreen extends ConsumerWidget {
  const HuntingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final levelProviderGet = ref.watch(levelProvider);
    final mq = MediaQueryValues(context);
    return ListView(
      children: [..._huntingCardsBasedSubLevel(levelProviderGet)],
    );
  }

  List<Widget> _huntingCardsBasedSubLevel(Enum level) {
    if (level == Level.sslc) {
      return [
        Huntingcards(title: 'Kerala Renaissance'),
        Huntingcards(title: 'Indian History'),
        Huntingcards(title: 'Geography (India & Kerala)'),
        Huntingcards(title: 'General Science'),
        Huntingcards(title: 'Basic Computer Knowledge'),
        Huntingcards(title: 'Simple Arithmetic'),
        Huntingcards(title: 'English Grammar'),
        Huntingcards(title: 'Malayalam Grammar'),
      ];
    } else if (level == Level.plusTwo) {
      return [
        Huntingcards(title: 'Kerala Renaissance'),
        Huntingcards(title: 'Indian History'),
        Huntingcards(title: 'Indian Geography'),
        Huntingcards(title: 'Indian Polity & Constitution'),
        Huntingcards(title: 'Indian Economy ( + Kerala model)'),
        Huntingcards(title: 'Environmental Science'),
        Huntingcards(title: 'Arithmetic'),
        Huntingcards(title: 'English Grammar & Usage'),
        Huntingcards(title: 'Malayalam Grammar'),
        Huntingcards(title: 'Computer Awareness '),
      ];
    } else {
      return [
        Huntingcards(title: 'Kerala Renaissance'),
        Huntingcards(title: 'Modern Indian History '),
        Huntingcards(title: 'Indian Polity & Constitution'),
        Huntingcards(title: 'Indian Geography'),
        Huntingcards(title: 'Indian Economy '),
        Huntingcards(title: 'Environmental Science & Ecology'),
        Huntingcards(title: 'General Science'),
        Huntingcards(title: 'Quantitative Aptitude '),
        Huntingcards(title: 'English Grammar & Comprehension'),
        Huntingcards(title: 'Malayalam Grammar'),

        Huntingcards(title: 'Computer & Cyber Awareness'),
      ];
    }
  }
}
