import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:psc_learner/core/constants/colors.dart';
import 'package:psc_learner/core/constants/text_style.dart';
import 'package:psc_learner/core/utils/utils.dart';
import 'package:psc_learner/features/auth/screens/sign_up/providers/auth_provider.dart';
import 'package:psc_learner/widgets/customTextField.dart';

class VerificationScreen extends ConsumerWidget {
  VerificationScreen({super.key});
  final TextEditingController _emailcontroller = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // handle verfication email

    void _handleVerificationLink() async {
      final email = _emailcontroller.text.trim();

      if (email.isEmpty) {
        scaffoldshow('Email is required, please fill that', context);
        return;
      }

      final res = await ref.read(verificationProvider(email).future);
      scaffoldshow(res, context);
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          iconTheme: IconThemeData(color: buttonWhite),
          backgroundColor: bgcolor,
          title: Text(
            'Verification email',
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Customtextfield(
                    email: 'Email',
                    type: TextInputType.emailAddress,
                    controller: _emailcontroller,
                    isPassword: false,
                  ),
                  SizedBox(height: 20),
                
                      Text(
                        'First, check your inbox or spam for any existing verification link',
                        textAlign: TextAlign.center,
                        style: KtextStyle.forget,
                      ),Text(
                        'G mail ➡ spam or inbox',
                        textAlign: TextAlign.center,
                        style: KtextStyle.forget,
                      ),
                  
                  ElevatedButton(
                    onPressed: () {
                      _handleVerificationLink();
                      _emailcontroller.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kbluehard,
                      foregroundColor: buttonWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide.none,
                      ),
                      elevation: 0,
                    ),
                    child: Text('Send Verification Link'),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Click the button to get verification  link',
                    style: KtextStyle.forget,
                  ),
                  Text(
                    'Also check inbox or spam for verification link',
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
