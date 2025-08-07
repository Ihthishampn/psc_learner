import 'package:flutter/material.dart';
import 'package:psc_learner/core/constants/colors.dart';

scaffoldshow(String messg, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: 3),
      backgroundColor: kblack,
      content: Text(messg, style: TextStyle(color: buttonWhite)),
    ),
  );
}

class MediaQueryValues {
  final BuildContext context;
  MediaQueryValues(this.context);

  double get height => MediaQuery.of(context).size.height;
  double get width => MediaQuery.of(context).size.width;
}

const dividerWidget = Divider(indent: 10, endIndent: 10);
