import 'package:flutter/material.dart';
import 'package:psc_learner/core/constants/colors.dart';
import 'package:psc_learner/core/constants/text_style.dart';
import 'package:psc_learner/features/Current_affair/widgets/currentAffairWidget.dart';

class CurrentAffairs extends StatelessWidget {
  const CurrentAffairs({super.key});

  @override
  Widget build(BuildContext context) {
    // Example texts

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Current Affairs',
          style: KtextStyle.subHeadings.copyWith(fontSize: 24),
        ),
        backgroundColor: bgcolor,
      ),
      body: ListView(
        children: [
          const Divider(indent: 18, endIndent: 18),
          Currentaffairwidget(),
          const Divider(
            indent: 38,
            endIndent: 38,
            color: Color.fromARGB(255, 144, 153, 157),
          ),

          Currentaffairwidget(),
          Currentaffairwidget(),
          Currentaffairwidget(),
        ],
      ),
    );
  }
}
