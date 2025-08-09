import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:psc_learner/main.dart';

enum Level { sslc, plusTwo, degree }


final levelProvider = StateProvider<Level>((ref) {
  final index = prefs.getInt('slectedLevel') ?? 0;
  return Level.values[index];
});
