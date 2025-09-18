import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:psc_learner/features/profile/providers/provider_sort.dart';
import 'package:psc_learner/main.dart';

class Dropdownwidget extends ConsumerWidget {
  const Dropdownwidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final level = ref.watch(levelProvider); // Level? now

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<Level>(
          value: level,
          decoration: InputDecoration(
            labelText: 'Select Level',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          items: Level.values
              .map(
                (lvl) => DropdownMenuItem(
                  value: lvl,
                  child: Text(lvl.name.toUpperCase()),
                ),
              )
              .toList(),
          onChanged: (val) {
            if (val != null) {
              ref.read(levelProvider.notifier).state = val;
              prefs.setInt('selectedLevel', val.index);
            }
          },
        ),

        if (level != null)
          Text('✅ Level ${level.name.toUpperCase()} selected')
        else
          const Text('Please select a level'),
      ],
    );
  }
}
