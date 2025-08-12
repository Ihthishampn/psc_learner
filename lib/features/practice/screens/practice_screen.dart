import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:psc_learner/core/constants/colors.dart';
import 'package:psc_learner/core/constants/text_style.dart';
import 'package:psc_learner/features/practice/TapBarScreens/all_in_one_test_screen.dart';
import 'package:psc_learner/features/practice/TapBarScreens/hunting_screen.dart';
import 'package:psc_learner/features/practice/TapBarScreens/timed_tests_screen.dart';
import 'package:psc_learner/features/practice/providers/tab_nav_provider.dart';
import 'package:psc_learner/features/profile/providers/provider_sort.dart';

class MockTest extends ConsumerStatefulWidget {
  const MockTest({super.key});

  @override
  ConsumerState<MockTest> createState() => _MockTestState();
}

class _MockTestState extends ConsumerState<MockTest>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _pages = const [
    _KeepAlivePage(child: TimedTestsScreen(), key: PageStorageKey("timed")),
    _KeepAlivePage(child: HuntingScreen(), key: PageStorageKey("hunting")),
    _KeepAlivePage(child: AllInOneTestScreen(), key: PageStorageKey("allin")),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _pages.length, vsync: this);

    // Keep Riverpod in sync
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        ref.read(tabIndexProvider.notifier).state = _tabController.index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final levelTitle = ref.watch(levelProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgcolor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('PRACTICE', style: KtextStyle.subHeadings),
            Text(
              "|${levelTitle?.name.toUpperCase()}|",
              style: KtextStyle.subHeadings,
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          dividerColor: bgcolor,
          indicator: BoxDecoration(
            color: const Color.fromARGB(222, 63, 91, 128),
            borderRadius: BorderRadius.circular(12),
          ),
          indicatorSize: TabBarIndicatorSize.label,
          labelPadding: const EdgeInsets.symmetric(horizontal: 8),
          labelColor: Colors.white,
          unselectedLabelColor: const Color.fromARGB(255, 132, 131, 131),
          tabs: [
            _buildTab('Timed Practice'),
            _buildTab('Hunting Test'),
            _buildTab('All In Test'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const BouncingScrollPhysics(), // Smooth swipe feel
        children: _pages,
      ),
    );
  }

  Widget _buildTab(String text) {
    return Tab(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        child: Text(text),
      ),
    );
  }
}

class _KeepAlivePage extends StatefulWidget {
  final Widget child;
  const _KeepAlivePage({required this.child, super.key});

  @override
  State<_KeepAlivePage> createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<_KeepAlivePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
