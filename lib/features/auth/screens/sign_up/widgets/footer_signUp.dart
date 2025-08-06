

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:psc_learner/core/constants/text_style.dart';

class FooterSignup extends StatelessWidget {
  const FooterSignup({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Already have an account?", style: KtextStyle.normaltext),
        TextButton(
          onPressed: () {
              FocusScope.of(context).unfocus(); // 👈 dismiss keyboard if open
            context.pop();
          },
          child: Text('Login', style: KtextStyle.roboto,),
        ),
      ],
    );
  }
}
