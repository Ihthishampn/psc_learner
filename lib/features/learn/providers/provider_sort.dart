import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Load shared preferences once
final sharedPrefsProvider = FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

// Notifier to manage selected level
final selectedLevelProvider =
    StateNotifierProvider<SelectedLevelNotifier, String>((ref) {
  final prefs = ref.watch(sharedPrefsProvider).maybeWhen(
        data: (data) => data,
        orElse: () => null,
      );
  return SelectedLevelNotifier(prefs);
});

class SelectedLevelNotifier extends StateNotifier<String> {
  final SharedPreferences? prefs;

  SelectedLevelNotifier(this.prefs) : super('SSLC') {
    _loadLevel();
  }

  void _loadLevel() {
    final saved = prefs?.getString('level');
    if (saved != null) state = saved;
  }

  void setLevel(String newLevel) {
    state = newLevel;
    prefs?.setString('level', newLevel);
  }
}
