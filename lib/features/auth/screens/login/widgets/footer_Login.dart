

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:psc_learner/core/constants/text_style.dart';

class FooterLogin extends StatelessWidget {
  const FooterLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("New here? Tap to", style: KtextStyle.normaltext),
        TextButton(
          onPressed: () {
            context.push('/signUp');
          },
          child: Text('Sign Up', style: KtextStyle.roboto),
        ),
      ],
    );
  }
}
