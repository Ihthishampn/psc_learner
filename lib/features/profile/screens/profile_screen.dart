import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:psc_learner/core/constants/colors.dart';
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
        titleSpacing: 29,
        backgroundColor: bgcolor,
        title: Text(
          'Profile',
          style: TextStyle(color: buttonWhite, fontWeight: FontWeight.bold),
        ),
        actions: [
         IconButton(

onPressed: () async {
  final confirm = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Log out"),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Log out"),
          ),
        ],
      );
    },
  );

  if (confirm == true) {
    await FirebaseAuth.instance.signOut();
    // Use GoRouter navigation:
    GoRouter.of(context).go('/login'); // <<<<< This replaces the route
  }
},

  icon: const Icon(Icons.logout, color: Colors.white),
        )

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
