import 'package:flutter/material.dart';
import 'package:psc_learner/core/constants/colors.dart';

class Cutombutton extends StatelessWidget {
  final String name;
  final VoidCallback onclick;
  const Cutombutton({super.key, required this.name, required this.onclick});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: onclick,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(kbluehard),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(12),
          ),
        ),
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: size.width * 0.28),
        ),
      ),
      child: Text(
        name,
        style: TextStyle(color: buttonWhite, fontWeight: FontWeight.bold),
      ),
    );
  }
}
