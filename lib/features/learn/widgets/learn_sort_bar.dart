import 'package:flutter/material.dart';
import 'package:psc_learner/core/constants/colors.dart';
import 'package:psc_learner/core/constants/text_style.dart';

class LearnSortBar extends StatelessWidget {
  const LearnSortBar({super.key});

  void _showLearningNotice(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color.fromARGB(222, 72, 91, 115),
        title: const Text(
          'Important Notice',
          style: TextStyle(fontWeight: FontWeight.bold,color: buttonWhite),
        ),
        content: const Text(
          'Note: This application is not affiliated with PSC content and may contain duplicate questions.',style: TextStyle(color: buttonWhite),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Learn',
            style: KtextStyle.normaltext.copyWith(
              fontSize: 26,
              color: const Color.fromARGB(255, 128, 154, 201),
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: lightWhite.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              onPressed: () => _showLearningNotice(context),
              icon: const Icon(Icons.info_outline),
              iconSize: 24,
              color: const Color.fromARGB(255, 168, 94, 89),
              style: IconButton.styleFrom(
                backgroundColor: Colors.transparent,
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
