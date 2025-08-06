

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:psc_learner/core/constants/colors.dart';
import 'package:psc_learner/core/constants/text_style.dart';
import 'package:psc_learner/core/utils/utils.dart';
import 'package:psc_learner/features/auth/screens/sign_up/providers/auth_provider.dart';
import 'package:psc_learner/widgets/customTextField.dart';

class ForgetScreen extends ConsumerStatefulWidget {
  const ForgetScreen({super.key});

  @override
  ConsumerState<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends ConsumerState<ForgetScreen> {
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleResetPassword() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      scaffoldshow('Email is required', context);
      return;
    }

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => const AlertDialog(
        backgroundColor: bgcolor,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: buttonWhite),
            SizedBox(width: 20),
            Text("Sending reset link...", style: TextStyle(color: buttonWhite)),
          ],
        ),
      ),
    );

    try {
      await ref.read(reserpassprovider(email).future);

      if (context.mounted) {
        Navigator.of(context).pop();
        scaffoldshow(
          'If this email is registered, a reset link has been sent. Check inbox or spam.',
          context,
        );
        context.go('/login');
      }
    } catch (e) {
      if (context.mounted) Navigator.of(context).pop();
      scaffoldshow(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: buttonWhite),
          backgroundColor: bgcolor,
          title: const Text(
            'Forget Password',
            style: TextStyle(
              color: buttonWhite,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Customtextfield(
                    email: 'Email',
                    type: TextInputType.emailAddress,
                    controller: _emailController,
                    isPassword: false,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _handleResetPassword();
                      _emailController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kbluehard,
                      foregroundColor: buttonWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text('Send Reset Link'),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Click the button to receive a password reset link.',
                    style: KtextStyle.forget,
                  ),
                  Text(
                    'Check your inbox or spam folder for the reset link.',
                    style: KtextStyle.forget,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



