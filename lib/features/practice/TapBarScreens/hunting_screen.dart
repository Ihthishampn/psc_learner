
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:psc_learner/core/constants/colors.dart';
import 'package:psc_learner/core/constants/text_style.dart';
import 'package:psc_learner/core/utils/utils.dart';
import 'package:psc_learner/features/practice/providers/provider_test.dart';
import 'package:psc_learner/features/profile/providers/provider_sort.dart';




// Quiz Screen
class QuizScreen extends ConsumerStatefulWidget {
  final String category;
  
  const QuizScreen({super.key, required this.category});

  @override
  ConsumerState<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(quizProvider.notifier).startQuiz(widget.category);
      // Start timers
      ref.read(questionTimerProvider.notifier);
      ref.read(totalTimerProvider.notifier);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final quizState = ref.watch(quizProvider);
    final questionTimeLeft = ref.watch(questionTimerProvider);
    
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        final shouldExit = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit Quiz'),
            content: const Text('Are you sure you want to exit? Your progress will be lost.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        );
        return shouldExit ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: buttonWhite),
          backgroundColor: bgcolor,
          title: Text(widget.category,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
          actions: [
            // Total timer
           
          ],
        ),
        body: quizState.quizCompleted
            ? (quizState.showResults 
                ? QuizResultsOverview(score: quizState.score, total: quizState.questions.length, userAnswers: quizState.userAnswers)
                : QuizResults(score: quizState.score, total: quizState.questions.length, userAnswers: quizState.userAnswers))
            : _buildQuizContent(quizState, questionTimeLeft),
      ),
    );
  }

Widget _buildQuizContent(QuizState quizState, int questionTimeLeft) {
  if (quizState.questions.isEmpty) {
    return const Center(
      child: Text(
        "No questions available",
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }

  final currentQuestion = quizState.questions[quizState.currentQuestionIndex];
  final options = currentQuestion['options'] as List<String>;
    
    return Column(
      children: [
        // Progress bar
        LinearProgressIndicator(
          value: (quizState.currentQuestionIndex + 1) / quizState.questions.length,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        ),
        
        // Question timer
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Question ${quizState.currentQuestionIndex + 1}/${quizState.questions.length}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: buttonWhite),
              ),
              Text(
                '${questionTimeLeft}s',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: questionTimeLeft <= 5 ? Colors.red : Colors.white,
                ),
              ),
            ],
          ),
        ),
        
        // Question
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentQuestion['question'],
                  style: KtextStyle.questionStyle.copyWith(fontSize: 20,color: buttonWhite),
                ),
                const SizedBox(height: 24),
                ...options.asMap().entries.map((entry) {
                  final index = entry.key;
                  final option = entry.value;
                  
                  Color getColor() {
                    if (quizState.selectedAnswerIndex == -1) return Colors.grey;
                    if (index == currentQuestion['correctAnswer']) return Colors.green;
                    if (index == quizState.selectedAnswerIndex) return Colors.red;
                    return Colors.grey;
                  }
                  
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: ElevatedButton(
                      onPressed: quizState.selectedAnswerIndex == -1
                          ? () => ref.read(quizProvider.notifier).selectAnswer(index)
                          : null,
                      style: ElevatedButton.styleFrom(
                        // ignore: deprecated_member_use
                        backgroundColor: getColor().withOpacity(0.1),
                        foregroundColor: getColor(),
                        side: BorderSide(color: getColor()),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: Text(option,style: TextStyle(color: buttonWhite),),
                    ),
                  );
                // ignore: unnecessary_to_list_in_spreads
                }).toList(),
              ],
            ),
          ),
        ),
        
        // Score
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: bgcolor,
            border: Border(top: BorderSide(color: Colors.grey[300]!)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Score: ${quizState.score}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: buttonWhite),
              ),
              ElevatedButton(
  onPressed: () => ref.read(quizProvider.notifier).nextQuestion(),
  style: ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12), // change 20 to your desired roundness
    ),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), // optional, for bigger button
  ),
  child: const Text('Skip Question',style: TextStyle(color: Colors.black),),
),

            ],
          ),
        ),
      ],
    );
  }
}

// Quiz Results Screen
class QuizResults extends ConsumerWidget {
  final int score;
  final int total;
  final List<int> userAnswers;
  
  const QuizResults({super.key, required this.score, required this.total, required this.userAnswers});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Quiz Completed!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: buttonWhite),
          ),
          const SizedBox(height: 20),
          Text(
            'Your Score: $score/$total',
            style: const TextStyle(fontSize: 20,color: buttonWhite),
          ),
          const SizedBox(height: 30),
         Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Expanded(
      child: ElevatedButton(
        onPressed: () => Navigator.of(context).pop(),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text('Back to syllabus test scren',style: TextStyle(color: Colors.black),),
      ),
    ),
    const SizedBox(width: 6),
    Expanded(
      child: ElevatedButton(
        onPressed: () => ref.read(quizProvider.notifier).showResultsOverview(),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text('Review Answers',style: TextStyle(color: Colors.black),),
      ),
    ),
  ],
)

        ],
      ),
    );
  }
}

// Quiz Results Overview Screen
class QuizResultsOverview extends ConsumerWidget {
  final int score;
  final int total;
  final List<int> userAnswers;
  
  const QuizResultsOverview({super.key, required this.score, required this.total, required this.userAnswers});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questions = ref.read(quizProvider).questions;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgcolor,
        iconTheme: IconThemeData(color: bgcolor),
        title: const Text('Quiz Results',style: TextStyle(color: buttonWhite,fontWeight: FontWeight.bold),),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text('Score', style: TextStyle(fontSize: 16)),
                    Text('$score/$total', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: [
                    const Text('Percentage', style: TextStyle(fontSize: 16)),
                    Text('${(score / total * 100).toStringAsFixed(1)}%', 
                         style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final question = questions[index];
                final userAnswer = userAnswers[index];
                final correctAnswer = question['correctAnswer'];
                final isCorrect = userAnswer == correctAnswer;
                
                return Card(
                  margin: const EdgeInsets.all(8),
                  color: isCorrect ? Colors.green[50] : Colors.red[50],
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Q${index + 1}: ${question['question']}', 
                             style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text('Your answer: ${userAnswer != -1 ? question['options'][userAnswer] : 'Not answered'}',
                             style: TextStyle(color: isCorrect ? Colors.green : Colors.red)),
                        Text('Correct answer: ${question['options'][correctAnswer]}',
                             style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Back to syllabus test screen'),
            ),
          ),
        ],
      ),
    );
  }
}

// Hunting Screen with Category Cards
class HuntingScreen extends ConsumerWidget {
  const HuntingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final levelProviderGet = ref.watch(levelProvider);
    return ListView(
      children: [..._huntingCardsBasedSubLevel(levelProviderGet ?? Level.sslc)],
    );
  }

  List<Widget> _huntingCardsBasedSubLevel(Enum level) {
    if (level == Level.sslc) {
      return [
        Huntingcards(title: 'Kerala Renaissance'),
        Huntingcards(title: 'Indian History'),
        Huntingcards(title: 'Geography (India & Kerala)'),
        Huntingcards(title: 'General Science'),
        Huntingcards(title: 'Basic Computer Knowledge'),
        Huntingcards(title: 'Simple Arithmetic'),
        Huntingcards(title: 'English Grammar'),
        Huntingcards(title: 'Malayalam Grammar'),
      ];
    } else if (level == Level.plusTwo) {
      return [
        Huntingcards(title: 'Kerala Renaissance'),
        Huntingcards(title: 'Indian History'),
        Huntingcards(title: 'Indian Geography'),
        Huntingcards(title: 'Indian Polity & Constitution'),
        Huntingcards(title: 'Indian Economy'),
        Huntingcards(title: 'Environmental Science'),
        Huntingcards(title: 'Arithmetic'),
        Huntingcards(title: 'English Grammar & Usage'),
        Huntingcards(title: 'Malayalam Grammar'),
        Huntingcards(title: 'Computer Awareness '),
      ];
    } else {
      return [
        Huntingcards(title: 'Kerala Renaissance'),
        Huntingcards(title: 'Modern Indian History '),
        Huntingcards(title: 'Indian Polity & Constitution'),
        Huntingcards(title: 'Indian Geography'),
        Huntingcards(title: 'Indian Economy '),
        Huntingcards(title: 'Environmental Science & Ecology'),
        Huntingcards(title: 'General Science'),
        Huntingcards(title: 'Quantitative Aptitude '),
        Huntingcards(title: 'English Grammar & Comprehension'),
        Huntingcards(title: 'Malayalam Grammar'),
        Huntingcards(title: 'Computer & Cyber Awareness'),
      ];
    }
  }
}

// Hunting Cards Widget
class Huntingcards extends StatelessWidget {
  final String title;
  const Huntingcards({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQueryValues(context);
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        height: mq.height * 0.11,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Color.fromARGB(255, 248, 250, 255),
            ],
          ),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color.fromARGB(255, 230, 235, 245),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.white.withOpacity(0.8),
              blurRadius: 1,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const SizedBox(width: 16),
              
              // Title section
              Expanded(
                child: Text(
                  title,
                  style: KtextStyle.questionStyle.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 40, 40, 40),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              
              const SizedBox(width: 12),
              
              // Start button
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(222, 41, 65, 97),
                      Color.fromARGB(222, 50, 75, 107),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: const Color.fromARGB(222, 41, 65, 97).withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizScreen(category: title),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Start',
                        style: TextStyle(
                          color: buttonWhite,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(
                        Icons.play_arrow_rounded,
                        color: buttonWhite,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}