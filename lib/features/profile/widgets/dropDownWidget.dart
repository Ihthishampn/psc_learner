import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:psc_learner/features/profile/providers/provider_sort.dart';
import 'package:psc_learner/main.dart';
import 'package:psc_learner/providers/fetchQusFromFirebase.dart';
class Dropdownwidget extends ConsumerWidget {
  const Dropdownwidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final level = ref.watch(levelProvider);
    final fetchProgress = ref.watch(fetchProgressProvider);
    final questionsAsync = ref.watch(questionsProvider(level));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<Level>(
          value: level,
          decoration: InputDecoration(
            labelText: 'Select Level',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          items: Level.values.map((lvl) => DropdownMenuItem(
            value: lvl,
            child: Text(lvl.name.toUpperCase()),
          )).toList(),
          onChanged: (val) async {
            if (val != null) {
              ref.read(levelProvider.notifier).state = val;
              prefs.setInt('selectedLevel', val.index);
              ref.read(fetchProgressProvider.notifier).state = 0;
              await ref.refresh(questionsProvider(val)).value;
            }
          },
        ),
        questionsAsync.when(
          loading: () => Column(
            children: [
              LinearProgressIndicator(value: fetchProgress / 100),
              Text('Loading... ${fetchProgress.toStringAsFixed(0)}%'),
            ],
          ),
          error: (err, stack) => Text('Error: $err'),
          data: (questions) {
            if (questions.isEmpty) {
              return const Text('No questions found for this level');
            }
            return Text('✅ ${questions.length} questions loaded');
          },
        ),
      ],
    );
  }
}