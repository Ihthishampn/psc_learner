import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final auth = FirebaseAuth.instance;
            await auth.signOut();
            context.go('/login');
          },
          child: Text('logout'),
        ),
      ),
    );
  }
}
