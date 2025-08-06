import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:psc_learner/core/constants/colors.dart';
import 'package:psc_learner/features/auth/screens/login/providers/password_visibility_provider.dart';

class Customtextfield extends ConsumerWidget {
  final String email;
  final Icon? icondataPrefix;
  final TextInputType type;
  final TextEditingController controller;
  final bool isPassword;

  const Customtextfield({
    super.key,
    required this.email,
    this.icondataPrefix,
    required this.type,
    required this.controller,
    required this.isPassword,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final obscure = ref.watch(passworVisibilityStateProvider);
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: TextField(
        obscureText: isPassword ? obscure : false,
        controller: controller,
        style: TextStyle(fontSize: 16, color: buttonWhite),
        decoration: InputDecoration(
          hintText: email,
          hintStyle: TextStyle(
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(172, 167, 166, 166),
          ),
          prefixIcon: icondataPrefix,
          suffixIcon: isPassword
              ? IconButton(
                  onPressed: () {
                    ref.read(passworVisibilityStateProvider.notifier).state =
                        !obscure;
                  },
                  icon: obscure
                      ? Icon(Icons.visibility_off, color: lightWhite)
                      : Icon(Icons.visibility, color: lightWhite),
                )
              : null,
          fillColor: bgcolor,
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: const Color.fromARGB(255, 64, 110, 191),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: const Color.fromARGB(255, 30, 76, 94),
              width: 2,
            ),
          ),
        ),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }
}
