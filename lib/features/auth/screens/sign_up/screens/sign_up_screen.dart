// sign up page
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:psc_learner/core/constants/colors.dart';
import 'package:psc_learner/core/utils/utils.dart';
import 'package:psc_learner/features/auth/screens/sign_up/providers/auth_provider.dart';
import 'package:psc_learner/features/auth/screens/sign_up/widgets/footer_signUp.dart';
import 'package:psc_learner/widgets/customTextField.dart';
import 'package:psc_learner/widgets/cutomButton.dart';
import 'package:psc_learner/widgets/widgets.dart';

class SignUpScreen extends ConsumerWidget {
  SignUpScreen({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userName = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void handleSignUp(BuildContext context) async {
      final email = _emailController.text.trim();
      final username = _userName.text;
      final password = _passwordController.text.trim();

      if (email.isEmpty || username.isEmpty || password.isEmpty) {
        scaffoldshow('please fill all fields', context);
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
              Text(
                "Sign up in progress...",
                style: TextStyle(color: buttonWhite),
              ),
            ],
          ),
        ),
      );
      try {
        await ref.read(
          signUpProvider({
            'email': email,
            'password': password,
            'username': username,
          }).future,
        );

        if (context.mounted) {
          context.pop(); // close loader
          scaffoldshow(
            'Sign Up complete..Verification email sent. Please check your inbox before logging in check inbox or spam',
            context,
          );
          FocusScope.of(context).unfocus(); // 👈 dismiss keyboard if open
          context.go('/login');
        }
      } catch (e) {
        if (context.mounted) Navigator.pop(context); // close loader
        scaffoldshow(e.toString(), context);
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
                email: 'username',
                type: TextInputType.text,
                controller: _userName,
                icondataPrefix: Icon(Icons.person, color: lightWhite),
              ),
              SizedBox(height: size.height * 0.03),

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
                name: 'Sign Up',
                onclick: () {
                  handleSignUp(context);
                },
              ),
              SizedBox(height: size.height * 0.09),

              // footer section of  move to login
              FooterSignup(),
            ],
          ),
        ),
      ),
    );
  }
}
