import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:psc_learner/main.dart';

enum Level { sslc, plusTwo, degree }

final levelProvider = StateProvider<Level?>((ref) {
  final index = prefs.getInt('selectedLevel');
  if (index == null) return null; // No level selected yet
  return Level.values[index];
});

