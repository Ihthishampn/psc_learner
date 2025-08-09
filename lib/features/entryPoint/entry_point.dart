import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:psc_learner/core/constants/colors.dart';
import 'package:psc_learner/features/Current_affair/screens/current_affairs.dart';
import 'package:psc_learner/features/entryPoint/providers/entry_providers.dart';
import 'package:psc_learner/features/learn/learn_screen.dart';
import 'package:psc_learner/features/practice/screens/practice_screen.dart';
import 'package:psc_learner/features/profile/screens/profile_screen.dart';

class EntryPoint extends ConsumerStatefulWidget {
  const EntryPoint({super.key});

  @override
  ConsumerState<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends ConsumerState<EntryPoint> {
  final screens = const [
    LearnScreen(),
    MockTest(),
    CurrentAffairs(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final selectIndex = ref.watch(navtabprovider);

    return Scaffold(
      body: screens[selectIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: bgcolor,
        height: 60,
        animationDuration: Duration(milliseconds: 300),
        color: navcolor,
        buttonBackgroundColor: navcolor,
        index: selectIndex,
        items: const [
          Icon(Icons.menu_book, color: kblack),
          Icon(Icons.psychology_alt, color: kblack),
          Icon(Icons.campaign, color: kblack),
          Icon(Icons.person, color: kblack),
        ],
        onTap: (value) {
          ref.read(navtabprovider.notifier).state = value;
        },
      ),
    );
  }
}
