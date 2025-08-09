import 'package:flutter/material.dart';
import 'package:psc_learner/core/constants/colors.dart';
import 'package:psc_learner/core/constants/text_style.dart';
import 'package:psc_learner/core/utils/utils.dart';

class Huntingcards extends StatelessWidget {
  final title;
  const Huntingcards({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQueryValues(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: lightWhite,

          borderRadius: BorderRadius.circular(12),
        ),
        height: mq.height * 0.1,
        child: ListTile(
          title: Text(title, style: KtextStyle.questionStyle),

          trailing: ElevatedButton(
            style: ButtonStyle(
              elevation: WidgetStatePropertyAll(2),
              backgroundColor: WidgetStatePropertyAll(
                const Color.fromARGB(222, 41, 65, 97),
              ),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            onPressed: () {},
            child: Text('start', style: TextStyle(color: buttonWhite)),
          ),
        ),
      ),
    );
  }
}
