import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:psc_learner/features/profile/providers/provider_sort.dart';

class CurrentAffairs extends ConsumerWidget {
  const CurrentAffairs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final level = ref.watch(levelProvider);
    final box = Hive.box('questions');
    final questions = box.get(level.name, defaultValue: []);

    if (questions.isEmpty) {
      return const Center(
        child: Text(
          "No questions found. Please fetch first.",
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return ListView.builder(
      itemCount: questions.length,
      itemBuilder: (context, index) {
        final q = questions[index];
        return Card(
          color: Colors.blueGrey.shade800,
          margin: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  q['question'] ?? '',
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...List.generate(
                  (q['options'] as List).length,
                  (optIndex) => Text(
                    "- ${q['options'][optIndex]}",
                    style: const TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
