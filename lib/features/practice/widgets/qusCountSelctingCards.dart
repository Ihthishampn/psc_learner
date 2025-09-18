


// Selected question count
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedQusProvider = StateProvider<int?>((ref) => null);
class QusCountingSelectingCards extends ConsumerWidget {
  final String durationCount;
  const QusCountingSelectingCards({super.key, required this.durationCount});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedQus = ref.watch(selectedQusProvider);
    
    // Extract the number from the string (e.g., "15 qus" -> 15)
    final qusNumber = int.parse(durationCount.split(' ')[0]);
    final isSelected = selectedQus == qusNumber;

    return GestureDetector(
      onTap: () {
        ref.read(selectedQusProvider.notifier).state = qusNumber;
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