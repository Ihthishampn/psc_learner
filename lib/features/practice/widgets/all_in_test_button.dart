import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:psc_learner/features/profile/providers/provider_sort.dart';
class AllInTestButton extends ConsumerWidget {
  final title;
  const AllInTestButton(this.title, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final levelProviderGet = ref.watch(levelProvider);
    return buttonTestbasedLevel(levelProviderGet ?? Level.sslc, title,context);
  }
}

Widget buttonTestbasedLevel(Enum level, String title,BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.green.shade400,
            Colors.green.shade600,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      backgroundColor: Color.fromARGB(255, 3, 3, 3),
      content: Text("🚧 Not done yet..."),
      duration: Duration(seconds: 2),
    ),
  );
},

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.rocket_launch,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}