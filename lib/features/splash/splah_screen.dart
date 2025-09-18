import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:psc_learner/core/constants/colors.dart';
import 'package:psc_learner/core/constants/text_style.dart';
import 'package:psc_learner/core/utils/utils.dart';
import 'package:psc_learner/features/entryPoint/entry_point.dart';
import 'package:psc_learner/features/profile/widgets/dropDownWidget.dart';
import 'package:psc_learner/main.dart';
import 'package:psc_learner/widgets/widgets.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigateAfterSplash();
    });
  }
void _navigateAfterSplash() async {
  try {
    await Future.delayed(const Duration(seconds: 2));

    final user = FirebaseAuth.instance.currentUser;
    await user?.reload();
    final refreshedUser = FirebaseAuth.instance.currentUser;

    if (refreshedUser == null || !refreshedUser.emailVerified) {
      context.go('/login');
      return;
    }

    // ✅ Check if level is selected in SharedPreferences
    final selectedLevel = prefs.getInt('selectedLevel'); // 0, 1, 2 or null
    if (selectedLevel == null) {
      // No level selected → go to level selection page
      context.go('/levelSelection'); // add route for this page
    } else {
      // Level already selected → go to entry page
      context.go('/entry');
    }

  } catch (e) {
    context.go('/login');
    scaffoldshow('An error occurred: ${e.toString()}', context);
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: Text('Psc Learner', style: KtextStyle.heading)),
            SizedBox(height: 50),
            // app logo image
            logoimage(150),
          ],
        ),
      ),
    );
  }
}

class LevelSelectionPage extends ConsumerWidget {
  const LevelSelectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgcolor,
        title: const Text(
          "Select Your Level",
          style: TextStyle(fontWeight: FontWeight.bold, color: buttonWhite),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Dropdownwidget(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const EntryPoint()),
                  (route) => false,
                );
              },
              child: const Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }
}
