import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:psc_learner/core/constants/colors.dart';
import 'package:psc_learner/core/constants/text_style.dart';
import 'package:psc_learner/core/utils/utils.dart';
import 'package:psc_learner/features/learn/providers/provider_sort.dart';

class LearnSortBar extends ConsumerWidget {
  const LearnSortBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mq = MediaQueryValues(context);
    final selectedLevel = ref.watch(selectedLevelProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'Learn',
          style: KtextStyle.normaltext.copyWith(
            fontSize: 26,
            color: lightWhite,
          ),
        ),
        SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: mq.width * 0.32,
            height: 60,
            child: DropdownButtonFormField<String>(
              value: selectedLevel,
              dropdownColor: const Color.fromARGB(222, 106, 137, 175),
              decoration: InputDecoration(
                labelText: 'Select level',
                labelStyle: KtextStyle.subHeadings,
                border: InputBorder.none,
              ),
              style: const TextStyle(color: Colors.white),
              items: ['SSLC', '+2', 'DEGREE']
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e, style: const TextStyle(color: Colors.white)),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  ref.read(selectedLevelProvider.notifier).setLevel(value);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
