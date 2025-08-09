import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:psc_learner/features/profile/providers/provider_sort.dart';

class AllInTestButton extends ConsumerWidget {
  final title;
  const AllInTestButton(this.title, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final levelProviderGet = ref.watch(levelProvider);
    return buttonTestbasedLevel(levelProviderGet,title);
  }
}

Widget buttonTestbasedLevel(Enum level,String title) {
  if (level == Level.sslc) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(left: 37, right: 37),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
               Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Icon(Icons.rocket_launch, color: Colors.white, size: 26),
            ],
          ),
        ),
      ),
    );
  } else if (level == Level.plusTwo) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(left: 37, right: 37),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
               Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Icon(Icons.rocket_launch, color: Colors.white, size: 26),
            ],
          ),
        ),
      ),
    );
  } else {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(left: 37, right: 37),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
               Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Icon(Icons.rocket_launch, color: Colors.white, size: 26),
            ],
          ),
        ),
      ),
    );
  }
}
