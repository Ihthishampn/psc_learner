import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Selected duration
final selectedDurationProvider = StateProvider<String?>((ref) => null);
class DurationselctingCard extends ConsumerWidget {
  final String durationCount;
  const DurationselctingCard({super.key, required this.durationCount});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDuration = ref.watch(selectedDurationProvider);
    final isSelected = selectedDuration == durationCount;

    return GestureDetector(
      onTap: () {
        ref.read(selectedDurationProvider.notifier).state = durationCount;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey,
            width: 2,
          ),
        ),
        child: Text(
          durationCount,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}







