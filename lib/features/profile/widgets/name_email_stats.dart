import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:psc_learner/core/constants/colors.dart';
import 'package:psc_learner/core/constants/text_style.dart';
import 'package:psc_learner/features/profile/providers/provider_sort.dart';

class NameEmailStats extends ConsumerWidget {
  const NameEmailStats({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectLevel = ref.watch(levelProvider);
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Container(
decoration: BoxDecoration(

  color: const Color.fromARGB(222, 40, 69, 108),
  borderRadius: BorderRadius.circular(12)

),
padding: EdgeInsets.all(17),      
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ihthisham pno',
              style: KtextStyle.roboto.copyWith(color: buttonWhite),
            ),
            Text(
              'ihthishampno@gmail.com',
              style: KtextStyle.roboto.copyWith(color: buttonWhite),
            ),
            Text(
              'Current selected level : ${selectLevel?.name.toUpperCase()}',
              style: KtextStyle.roboto.copyWith(color: buttonWhite),
            ),
          ],
        ),
      ),
    );
  }
}
