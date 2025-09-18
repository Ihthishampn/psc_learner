import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:psc_learner/core/constants/colors.dart';
import 'package:psc_learner/core/constants/text_style.dart';
import 'package:psc_learner/core/qus.dart';
import 'package:psc_learner/features/practice/widgets/durationSelcting_card.dart';
import 'package:psc_learner/features/practice/widgets/qusCountSelctingCards.dart';
import 'package:psc_learner/features/profile/providers/provider_sort.dart';

// Providers for state management

class TimedTestsScreen extends ConsumerWidget {
  const TimedTestsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final levelproviderget = ref.watch(levelProvider);

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        ..._buildWidgetsTimeTest(levelproviderget ?? Level.sslc, context, ref),
      ],
    );
  }

  List<Widget> _buildWidgetsTimeTest(
      Enum level, BuildContext context, WidgetRef ref) {
    return [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Duration Selection
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Select the duration per question',
              style: KtextStyle.normaltext.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 2.5,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            children: const [
              DurationselctingCard(durationCount: '30 s'),
              DurationselctingCard(durationCount: '1 min'),
              DurationselctingCard(durationCount: '1.30 min'),
              DurationselctingCard(durationCount: '2 min'),
            ],
          ),
          const SizedBox(height: 24),
          
          // Question Count Selection
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Select the number of questions',
              style: KtextStyle.normaltext.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 2.5,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            children: const [
              QusCountingSelectingCards(durationCount: '15 qus'),
              QusCountingSelectingCards(durationCount: '20 qus'),
              QusCountingSelectingCards(durationCount: '25 qus'),
              QusCountingSelectingCards(durationCount: '30 qus'),
            ],
          ),
          const SizedBox(height: 32),
          
          // Start Test Button
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(222, 68, 93, 127),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                elevation: 4,
              ),
              onPressed: () {
                final selectedQus = ref.read(selectedQusProvider);
                final duration = ref.read(selectedDurationProvider);

                if (selectedQus == null || duration == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select duration and questions.'),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TestPage(
                      duration: duration,
                      qusCount: selectedQus,
                    ),
                  ),
                );
              },
              child: Text('START TEST', style: KtextStyle.normaltext.copyWith(fontSize: 16)),
            ),
          ),
        ],
      ),
    ];
  }
}

// ------------------- Test Page -------------------

class TestPage extends StatefulWidget {
  final String duration;
  final int qusCount;

  const TestPage({super.key, required this.duration, required this.qusCount});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int currentQus = 0;
  int score = 0;
  Timer? _timer;
  Timer? _testTimer;
  int remainingSeconds = 0;
  int totalTestSeconds = 0;
  int testRemaining = 0;
  int? selectedIndex;
  bool answered = false;
  List<Map<String, dynamic>> results = [];

  @override
  void initState() {
    super.initState();
    remainingSeconds = _parseDuration(widget.duration);
    totalTestSeconds = remainingSeconds * widget.qusCount;
    testRemaining = totalTestSeconds;

    _startTimerForQuestion();
    _startTestTimer();
  }

  int _parseDuration(String duration) {
    if (duration.contains("30 s")) return 30;
    if (duration.contains("1.30")) return 90;
    if (duration.contains("2 min")) return 120;
    return 60;
  }

  void _startTimerForQuestion() {
    _timer?.cancel();
    remainingSeconds = _parseDuration(widget.duration);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        setState(() => remainingSeconds--);
      } else {
        timer.cancel();
        _nextQuestion();
      }
    });
  }

  void _startTestTimer() {
    _testTimer?.cancel();
    _testTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (testRemaining > 0) {
        setState(() => testRemaining--);
      } else {
        timer.cancel();
        _showResult();
      }
    });
  }

  void _checkAnswer(int index) {
    if (answered) return;

    setState(() {
      selectedIndex = index;
      answered = true;
      final question = PSCQuestions.questions[currentQus];
      final isCorrect = index == question['correctAnswer'];

      if (isCorrect) score++;

      results.add({
        'question': question['question'],
        'selectedAnswer': index,
        'correctAnswer': question['correctAnswer'],
        'options': question['options'],
        'isCorrect': isCorrect,
      });
    });

    Future.delayed(const Duration(seconds: 2), _nextQuestion);
  }

  void _nextQuestion() {
    if (currentQus < widget.qusCount - 1) {
      setState(() {
        currentQus++;
        selectedIndex = null;
        answered = false;
      });
      _startTimerForQuestion();
    } else {
      _timer?.cancel();
      _testTimer?.cancel();
      _showResult();
    }
  }

  void _showResult() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("🎉 Test Finished", style: TextStyle(fontSize: 24)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Score: $score / ${widget.qusCount}",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("Time Taken: ${(totalTestSeconds - testRemaining)} seconds",
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Done"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _showReview();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Review"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showReview() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => ReviewBottomSheet(results: results),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _testTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = PSCQuestions.questions[currentQus];
    final progress = (currentQus + 1) / widget.qusCount;

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        final shouldExit = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Exit Quiz?"),
            content: const Text("Are you sure you want to exit? Your progress will be lost."),
            actions: [
              TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text("No")),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text("Yes"),
              ),
            ],
          ),
        );
        return shouldExit ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "PSC Quiz | ${widget.qusCount} Qs",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.blue.shade800,
          foregroundColor: Colors.white,
          actions: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Center(
                child: Text(
                  "⏳ ${testRemaining ~/ 60}:${(testRemaining % 60).toString().padLeft(2, '0')}",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress bar
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[300],
                color: Colors.blue,
                minHeight: 8,
                borderRadius: BorderRadius.circular(4),
              ),
              const SizedBox(height: 16),
              
              // Question info and timer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Question ${currentQus + 1} of ${widget.qusCount}",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: buttonWhite)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: remainingSeconds <= 10 ? Colors.red.shade100 : Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "⏱ $remainingSeconds s",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: remainingSeconds <= 10 ? Colors.red : Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              // Question
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Text(
                  question['question'],
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 24),
              
              // Options
              Expanded(
                child: ListView.builder(
                  itemCount: (question['options'] as List).length,
                  itemBuilder: (context, index) {
                    Color btnColor = Colors.white;
                    Color textColor = Colors.black;
                    Color borderColor = Colors.grey[300]!;
                    IconData? icon;
                    Color iconColor = Colors.transparent;

                    if (answered) {
                      if (index == question['correctAnswer']) {
                        btnColor = Colors.green.shade50;
                        textColor = Colors.green.shade800;
                        borderColor = Colors.green.shade300;
                        icon = Icons.check_circle;
                        iconColor = Colors.green;
                      } else if (index == selectedIndex) {
                        btnColor = Colors.red.shade50;
                        textColor = Colors.red.shade800;
                        borderColor = Colors.red.shade300;
                        icon = Icons.cancel;
                        iconColor = Colors.red;
                      }
                    }

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: btnColor,
                          foregroundColor: textColor,
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: borderColor, width: 1.5),
                          ),
                          elevation: 0,
                        ),
                        onPressed: answered ? null : () => _checkAnswer(index),
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text(
                                  String.fromCharCode(65 + index),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                question['options'][index],
                                style: TextStyle(fontSize: 16, color: textColor),
                              ),
                            ),
                            if (icon != null)
                              Icon(icon, color: iconColor, size: 20),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              // Stats bar
              if (answered)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Score: $score/${currentQus + 1}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Accuracy: ${score == 0 ? 0 : ((score / (currentQus + 1)) * 100).toStringAsFixed(1)}%",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        
        // Next button
        bottomNavigationBar: answered && currentQus < widget.qusCount - 1
            ? Container(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: _nextQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Next Question",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            : null,
      ),
    );
  }
}

// ------------------- Review Bottom Sheet -------------------

class ReviewBottomSheet extends StatelessWidget {
  final List<Map<String, dynamic>> results;

  const ReviewBottomSheet({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    final correctCount = results.where((r) => r['isCorrect']).length;
    final accuracy = (correctCount / results.length) * 100;

    return Container(
      padding: const EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Text("Quiz Review",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue.shade800)),
          const SizedBox(height: 16),
          
          // Summary stats
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text("$correctCount/${results.length}",
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const Text("Correct", style: TextStyle(fontSize: 14)),
                  ],
                ),
                Column(
                  children: [
                    Text("${accuracy.toStringAsFixed(1)}%",
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const Text("Accuracy", style: TextStyle(fontSize: 14)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          
          Expanded(
            child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final result = results[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  color: result['isCorrect'] ? Colors.green.shade50 : Colors.red.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              result['isCorrect'] ? Icons.check_circle : Icons.cancel,
                              color: result['isCorrect'] ? Colors.green : Colors.red,
                            ),
                            const SizedBox(width: 8),
                            Text("Q${index + 1}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: result['isCorrect'] ? Colors.green : Colors.red)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(result['question'],
                            style: const TextStyle(fontWeight: FontWeight.w500)),
                        const SizedBox(height: 12),
                        ...List.generate((result['options'] as List).length, (i) {
                          final isCorrect = i == result['correctAnswer'];
                          final isSelected = i == result['selectedAnswer'];
                          Color color = Colors.grey;
                          IconData? icon;

                          if (isCorrect) {
                            color = Colors.green;
                            icon = Icons.check_circle;
                          } else if (isSelected) {
                            color = Colors.red;
                            icon = Icons.cancel;
                          }

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                if (icon != null) Icon(icon, color: color, size: 16),
                                if (icon == null) const SizedBox(width: 16),
                                const SizedBox(width: 4),
                                Text("${String.fromCharCode(65 + i)}. ${result['options'][i]}",
                                    style: TextStyle(
                                        color: color,
                                        fontWeight: isCorrect || isSelected ? FontWeight.bold : FontWeight.normal)),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            ),
            child: const Text("Close Review"),
          ),
        ],
      ),
    );
  }
}
