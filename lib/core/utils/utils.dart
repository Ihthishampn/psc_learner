import 'package:flutter/material.dart';
import 'package:psc_learner/core/constants/colors.dart';

scaffoldshow(String messg,BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: Duration(seconds: 3),
    backgroundColor: kblack,
    content: Text(messg,style: TextStyle(color: buttonWhite),)));
}
