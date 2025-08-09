import 'package:flutter/material.dart';
import 'package:psc_learner/core/constants/text_style.dart';
import 'package:psc_learner/core/utils/utils.dart';

class AllInTestTakeALookWidget extends StatelessWidget {
  const AllInTestTakeALookWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQueryValues(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'take a look here,\nbefore start the activity',
          style: KtextStyle.answerStyle.copyWith(
            color: const Color.fromARGB(255, 188, 207, 189),
          ),
        ),
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => Dialog(
                backgroundColor: const Color.fromARGB(
                  255,
                  123,
                  158,
                  131,
                ), // Custom background
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                insetPadding: const EdgeInsets.symmetric(
                  horizontal: 40, // Reduces width from sides
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Height adjusts to content
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Here you will face a mixture of the whole syllabus. It’s better to try after practicing tests for specific subjects. The questions here are aligned like in the PSC exam.',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: mq.height * 0.01),
                      _buildBullet('100 questions'),
                      _buildBullet('Random current affairs included'),
                      _buildBullet('You have 1 minute per question'),
                      _buildBullet(
                        'Your stats will appear — improve day by day until you get better',
                      ),
                    ],
                  ),
                ),
              ),
            );
          },

          icon: Icon(Icons.fingerprint, color: Colors.green, size: 31),
        ),
      ],
    );
  }
}

Widget _buildBullet(String text) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.only(top: 6, right: 8),
        child: Icon(Icons.circle, size: 8, color: Colors.black),
      ),
      Expanded(child: Text(text)),
    ],
  );
}
