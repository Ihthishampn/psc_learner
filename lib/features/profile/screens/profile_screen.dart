import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:psc_learner/core/constants/colors.dart';
import 'package:psc_learner/core/constants/text_style.dart';
import 'package:psc_learner/features/practice/widgets/all_in_test_button.dart';
import 'package:psc_learner/features/profile/providers/provider_sort.dart';
import 'package:psc_learner/features/profile/widgets/change_level_widget.dart';
import 'package:psc_learner/features/profile/widgets/contact_support.dart';
import 'package:psc_learner/features/profile/widgets/name_email_stats.dart';
import 'package:psc_learner/features/profile/widgets/upgrade_pro_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const div = Divider(indent: 25, endIndent: 25);
    const sb = SizedBox(height: 15);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgcolor,
        title: Text(
          'Profile',
          style: TextStyle(color: buttonWhite, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings, color: Colors.white),
          ),
        ],
      ),
      body: ListView(
        children: [
          // change level widget
          ChngeLevelRow(), sb,
          div,
          sb,
          // name,email,and current level stats
          NameEmailStats(),
          sb,

          div,
          sb,

          // upgrade to pro
          UpgradeProWidget(),
          sb,

          div,
          sb,

          ContactSupport(),
          sb,

          div,
          sb,
        ],
      ),
    );
  }
}
