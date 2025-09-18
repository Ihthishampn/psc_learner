import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:psc_learner/core/constants/colors.dart';
import 'package:psc_learner/core/qus.dart';

final revealedAnswersProvider = StateProvider<Set<int>>((ref) => {});

final questionStatusProvider =
    StateNotifierProvider<QuestionStatusNotifier, Map<int, String>>(
      (ref) => QuestionStatusNotifier(),
    );

class QuestionStatusNotifier extends StateNotifier<Map<int, String>> {
  final Box<String> box = Hive.box<String>('questionStatusBox');

  QuestionStatusNotifier() : super({}) {
    // Load saved statuses from Hive
    final saved = box.toMap().map((key, value) => MapEntry(key as int, value));
    state = saved;
  }

  void setStatus(int index, String status) {
    box.put(index, status); // save to Hive
    state = {...state, index: status};
  }
}

class QuestionsPage extends ConsumerStatefulWidget {
  final String title;
  const QuestionsPage({super.key, required this.title});

  @override
  ConsumerState<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends ConsumerState<QuestionsPage> {
  late List<Map<String, dynamic>> shuffledQuestions;

  @override
  void initState() {
    super.initState();
    shuffledQuestions = List<Map<String, dynamic>>.from(PSCQuestions.questions)
      ..shuffle();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(revealedAnswersProvider.notifier).state = {};
    });
  }

  @override
  Widget build(BuildContext context) {
    final revealedAnswers = ref.watch(revealedAnswersProvider);
    final questionStatus = ref.watch(questionStatusProvider);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: bgcolor,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: shuffledQuestions.length,
        itemBuilder: (context, index) {
          final q = shuffledQuestions[index];
          final isRevealed = revealedAnswers.contains(index);
          final selectedStatus = questionStatus[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Question + menu
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'Q${index + 1}: ${q['question']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert),
                        onSelected: (status) {
                          ref
                              .read(questionStatusProvider.notifier)
                              .setStatus(index, status);
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'Complete',
                            child: Text('Complete ✅'),
                          ),
                          const PopupMenuItem(
                            value: 'Improvement',
                            child: Text('Improvement ✏️'),
                          ),
                          const PopupMenuItem(
                            value: 'Crush',
                            child: Text('Crush ⭐'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Show Answer + Selected Status
                  Row(
                    children: [
                      Expanded(
                        child: AnimatedSize(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: isRevealed
                              ? Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'Answer: ${q['options'][q['correctAnswer']]}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.green,
                                    ),
                                  ),
                                )
                              : ElevatedButton(
                                  onPressed: () {
                                    ref
                                        .read(revealedAnswersProvider.notifier)
                                        .update((state) {
                                          final newSet = Set<int>.from(state);
                                          newSet.add(index);
                                          return newSet;
                                        });
                                  },
                                  child: const Text('Show Answer'),
                                ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      if (selectedStatus != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            selectedStatus,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CompleteQuestionsPage extends StatelessWidget {
  const CompleteQuestionsPage({super.key});
  @override
  Widget build(BuildContext context) =>
      const CategoryQuestionsPage(category: 'Complete');
}

class ImprovementQuestionsPage extends StatelessWidget {
  const ImprovementQuestionsPage({super.key});
  @override
  Widget build(BuildContext context) =>
      const CategoryQuestionsPage(category: 'Improvement');
}

class CrushQuestionsPage extends StatelessWidget {
  const CrushQuestionsPage({super.key});
  @override
  Widget build(BuildContext context) =>
      const CategoryQuestionsPage(category: 'Crush');
}
class CategoryQuestionsPage extends ConsumerWidget {
  final String category;
  const CategoryQuestionsPage({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionStatus = ref.watch(questionStatusProvider);

    final filteredQuestions = PSCQuestions.questions
        .asMap()
        .entries
        .where((entry) => questionStatus[entry.key] == category)
        .toList();

    void showMessage(String msg, Color color) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg),
          backgroundColor: color,
          duration: const Duration(seconds: 1),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: buttonWhite),
        title: Text(
          '$category Questions',
          style: TextStyle(
              color: buttonWhite, fontWeight: FontWeight.bold, fontSize: 19),
        ),
        backgroundColor: bgcolor,
      ),
      body: filteredQuestions.isEmpty
          ? const Center(
              child: Text(
                'No questions added yet',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredQuestions.length,
              itemBuilder: (context, index) {
                final q = filteredQuestions[index].value;
                final qIndex = filteredQuestions[index].key;
                final selectedStatus = questionStatus[qIndex];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    // Show category/subject name
    if (q['category'] != null)
      Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.2),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            q['category'], // e.g., "Kerala Renaissance"
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.orange),
          ),
        ),
      ),

    // Question + 3-dot menu + remove
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            'Q${qIndex + 1}: ${q['question']}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
                            Theme(
                              data: Theme.of(context).copyWith(
                                splashFactory: NoSplash.splashFactory,
                              ),
                              child: PopupMenuButton<String>(
                                icon: const Icon(Icons.more_vert),
                                onSelected: (status) {
                                  ref
                                      .read(questionStatusProvider.notifier)
                                      .setStatus(qIndex, status);

                                  Color color = Colors.blue;
                                  if (status == 'Complete') color = Colors.green;
                                  else if (status == 'Improvement') color = Colors.orange;
                                  else if (status == 'Crush') color = Colors.red;

                                  showMessage(
                                      'Status set to "$status" for Q${qIndex + 1}',
                                      color);
                                },
                                itemBuilder: (context) => const [
                                  PopupMenuItem(
                                      value: 'Complete',
                                      child: Text('Complete ✅')),
                                  PopupMenuItem(
                                      value: 'Improvement',
                                      child: Text('Improvement ✏️')),
                                  PopupMenuItem(
                                      value: 'Crush', child: Text('Crush ⭐')),
                                ],
                              ),
                            ),
                            if (selectedStatus != null)
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  ref
                                      .read(questionStatusProvider.notifier)
                                      .setStatus(qIndex, '');
                                  showMessage(
                                      'Status removed from Q${qIndex + 1}',
                                      Colors.red);
                                },
                              ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Answer display
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Answer: ${q['options'][q['correctAnswer']]}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.green),
                          ),
                        ),
                        // Display selected status
                        if (selectedStatus != null && selectedStatus.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                selectedStatus,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
