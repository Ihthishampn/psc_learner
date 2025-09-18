import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Shared provider
final questionStatusProvider = StateNotifierProvider<QuestionStatusNotifier, Map<int, String>>(
  (ref) => QuestionStatusNotifier(),
);

class QuestionStatusNotifier extends StateNotifier<Map<int, String>> {
  QuestionStatusNotifier() : super({});

  void setStatus(int index, String status) {
    state = {...state, index: status};
  }
}
class TopLearnStatsGreenor extends StatelessWidget {
  final Map<int, String> questionStatus;
  final int questionIndex; // add this
  final Function(String) onStatusSelected;

  const TopLearnStatsGreenor({
    super.key,
    required this.questionStatus,
    required this.questionIndex,
    required this.onStatusSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Keep your old UI logic here
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () => onStatusSelected('Complete'),
          child: const Text('Complete'),
        ),
        ElevatedButton(
          onPressed: () => onStatusSelected('Improvement'),
          child: const Text('Improvement'),
        ),
        ElevatedButton(
          onPressed: () => onStatusSelected('Crush'),
          child: const Text('Crush'),
        ),
      ],
    );
  }
}


// ignore: unused_element
class _StatusButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _StatusButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: selected ? Colors.green : Colors.grey,
      ),
      onPressed: onTap,
      child: Text(label),
    );
  }
}
