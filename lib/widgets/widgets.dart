import 'package:flutter/widgets.dart';
import 'package:psc_learner/core/constants/images.dart';

Widget logoimage(double size) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Image(image: appLogoImage, width: size),
  );
}
