import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:psc_learner/main.dart';

enum Level { sslc, plusTwo, degree }


final levelProvider = StateProvider<Level>((ref) {
  final index = prefs.getInt('selectedLevel') ?? 0;  // fix key spelling here
  return Level.values[index];
});
