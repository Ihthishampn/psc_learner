import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:psc_learner/core/constants/text_style.dart';
import 'package:psc_learner/core/utils/utils.dart';
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
      await Future.delayed(Duration(seconds: 2));

    final user = FirebaseAuth.instance.currentUser;
    await user?.reload();
    final refreshedUser = FirebaseAuth.instance.currentUser;
    if (refreshedUser == null) {
      context.go('/login');
    } else if (!refreshedUser.emailVerified) {
      context.go('/login');
    } else {
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
