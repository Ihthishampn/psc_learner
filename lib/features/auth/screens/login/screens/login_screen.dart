// login page

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:psc_learner/core/constants/colors.dart';
import 'package:psc_learner/core/utils/utils.dart';
import 'package:psc_learner/features/auth/screens/login/widgets/footer_Login.dart';
import 'package:psc_learner/features/auth/screens/sign_up/providers/auth_provider.dart';
import 'package:psc_learner/widgets/customTextField.dart';
import 'package:psc_learner/widgets/cutomButton.dart';
import 'package:psc_learner/widgets/widgets.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void _handleLogin() async {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        scaffoldshow('Please fill all fields', context);
        return;
      }

      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: bgcolor,

          content: Row(
            children: [
              CircularProgressIndicator(color: buttonWhite),
              SizedBox(width: 20),
              Text("Logging in...", style: TextStyle(color: buttonWhite)),
            ],
          ),
        ),
      );

      try {
        final result = await ref.read(
          loginProvider({'email': email, 'password': password}).future,
        );
        if (context.mounted) Navigator.pop(context);
        if (result == null) {
          if (context.mounted) context.go('/entry');
          _emailController.clear();
          _passwordController.clear();
        } else {
          scaffoldshow(result, context);
        }
      } catch (e) {
        if (context.mounted) Navigator.pop(context); // Ensure dialog is closed
        final error = e.toString().replaceFirst('Exception ', '');
        scaffoldshow(error, context);
      }
    }

    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.24),
              Center(child: logoimage(95)),
              // textfield for login email
              SizedBox(height: size.height * 0.07),
              Customtextfield(
                isPassword: false,
                email: 'Email',
                type: TextInputType.emailAddress,
                controller: _emailController,
                icondataPrefix: Icon(Icons.email, color: lightWhite),
              ),
              SizedBox(height: size.height * 0.03),

              // textfield for password
              Customtextfield(
                icondataPrefix: Icon(Icons.lock, color: lightWhite),
                isPassword: true,
                email: 'Password',
                type: TextInputType.visiblePassword,
                controller: _passwordController,
              ),
              SizedBox(height: size.height * 0.02),
              // button for login
              Cutombutton(
                name: 'Login',
                onclick: () async {
                  _handleLogin();
                },
              ),

              TextButton(
                onPressed: () {
                  FocusScope.of(context).unfocus(); // 👈 Hide keyboard first
                  context.push('/foregetScreen');
                },
                child: Text(
                  'Forget Password',
                  style: TextStyle(color: buttonWhite),
                ),
              ),
              TextButton(
                onPressed: () {
                  context.push('/verification');
                },
                child: Text(
                  'sent verifcation email again',
                  style: TextStyle(color: buttonWhite),
                ),
              ),
              SizedBox(height: size.height * 0.07),
              // footer section of  move to sign up
              FooterLogin(),
            ],
          ),
        ),
      ),
    );
  }
}
