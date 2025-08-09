import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:psc_learner/core/constants/colors.dart';
import 'package:psc_learner/features/profile/providers/provider_sort.dart';
import 'package:psc_learner/main.dart';

class Dropdownwidget extends ConsumerWidget {
  const Dropdownwidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final level = ref.watch(levelProvider);
    return DropdownButtonFormField<Level>(
  value: level,
  dropdownColor: const Color.fromARGB(222, 53, 75, 107),
  style: null, // keep null or default, so selected value uses normal color
  decoration: InputDecoration(
    labelText: 'Select Level',
    labelStyle: TextStyle(color: buttonWhite),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
  ),
  items: Level.values
      .map(
        (lvl) => DropdownMenuItem<Level>(
          value: lvl,
          child: Text(
            lvl.name.toUpperCase(),
            style: const TextStyle(
              color: Colors.white, // dropdown list item text color
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      )
      .toList(),
  onChanged: (val) {
    if (val != null) {
      ref.read(levelProvider.notifier).state = val;
      prefs.setInt('slectedLevel', val.index);
    }
  },
);

  }
}
