// Quiz state management with Riverpod
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:psc_learner/core/qus.dart';

final quizProvider = StateNotifierProvider<QuizNotifier, QuizState>((ref) {
  return QuizNotifier(ref);
});

class QuizNotifier extends StateNotifier<QuizState> {
    final Ref ref;  // store ref here
  QuizNotifier(this.ref) : super(QuizState.initial());

 void startQuiz(String category) {
  final categoryQuestions = PSCQuestions.questions
      .where((q) => q['category'] == category)
      .toList();

  final questionsToUse =
      categoryQuestions.isNotEmpty ? categoryQuestions : PSCQuestions.questions;

  state = QuizState(
    questions: questionsToUse,
    currentQuestionIndex: 0,
    selectedAnswerIndex: -1,
    score: 0,
    quizCompleted: false,
    timePerQuestion: 30,
    totalTime: questionsToUse.length * 30,
    userAnswers: List.filled(questionsToUse.length, -1),
    showResults: false,
  );

  // 🔑 Reset both timers when starting a new quiz
  ref.read(questionTimerProvider.notifier).resetTimer();
  ref.read(totalTimerProvider.notifier).resetTimer(state.totalTime);
}


  void selectAnswer(int index) {
    if (state.quizCompleted || state.selectedAnswerIndex != -1) return;

    final isCorrect = index == state.questions[state.currentQuestionIndex]['correctAnswer'];
    
    // Update user answers
    final updatedUserAnswers = List<int>.from(state.userAnswers);
    updatedUserAnswers[state.currentQuestionIndex] = index;
    
    state = state.copyWith(
      selectedAnswerIndex: index,
      score: isCorrect ? state.score + 1 : state.score,
      userAnswers: updatedUserAnswers,
    );

    // Move to next question after 1 second
    Future.delayed(const Duration(seconds: 1), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
  if (state.questions.isEmpty) return;

  if (state.currentQuestionIndex < state.questions.length - 1) {
    state = state.copyWith(
      currentQuestionIndex: state.currentQuestionIndex + 1,
      selectedAnswerIndex: -1,
      timePerQuestion: 30,
    );
    ref.read(questionTimerProvider.notifier).resetTimer();
  } else {
    state = state.copyWith(quizCompleted: true);
  }
}



  void updateQuestionTime(int timeLeft) {
    state = state.copyWith(timePerQuestion: timeLeft);
  }

  void updateTotalTime(int timeLeft) {
    state = state.copyWith(totalTime: timeLeft);
  }
  
  void showResultsOverview() {
    state = state.copyWith(showResults: true);
  }

  void resetQuiz() {
    state = QuizState.initial();
  }
}

class QuizState {
  final List<Map<String, dynamic>> questions;
  final int currentQuestionIndex;
  final int selectedAnswerIndex;
  final int score;
  final bool quizCompleted;
  final int timePerQuestion;
  final int totalTime;
  final List<int> userAnswers;
  final bool showResults;

  QuizState({
    required this.questions,
    required this.currentQuestionIndex,
    required this.selectedAnswerIndex,
    required this.score,
    required this.quizCompleted,
    required this.timePerQuestion,
    required this.totalTime,
    required this.userAnswers,
    required this.showResults,
  });

  factory QuizState.initial() {
    return QuizState(
      questions: [],
      currentQuestionIndex: 0,
      selectedAnswerIndex: -1,
      score: 0,
      quizCompleted: false,
      timePerQuestion: 30,
      totalTime: 0,
      userAnswers: [],
      showResults: false,
    );
  }

  QuizState copyWith({
    List<Map<String, dynamic>>? questions,
    int? currentQuestionIndex,
    int? selectedAnswerIndex,
    int? score,
    bool? quizCompleted,
    int? timePerQuestion,
    int? totalTime,
    List<int>? userAnswers,
    bool? showResults,
  }) {
    return QuizState(
      questions: questions ?? this.questions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      selectedAnswerIndex: selectedAnswerIndex ?? this.selectedAnswerIndex,
      score: score ?? this.score,
      quizCompleted: quizCompleted ?? this.quizCompleted,
      timePerQuestion: timePerQuestion ?? this.timePerQuestion,
      totalTime: totalTime ?? this.totalTime,
      userAnswers: userAnswers ?? this.userAnswers,
      showResults: showResults ?? this.showResults,
    );
  }
}

// Timer functionality using Riverpod
final questionTimerProvider = StateNotifierProvider<QuestionTimerNotifier, int>((ref) {
  return QuestionTimerNotifier(ref);
});

final totalTimerProvider = StateNotifierProvider<TotalTimerNotifier, int>((ref) {
  return TotalTimerNotifier(ref);
});

class QuestionTimerNotifier extends StateNotifier<int> {
  final Ref ref;
  Timer? _timer;

  QuestionTimerNotifier(this.ref) : super(30) {
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state > 0) {
        state--;
        ref.read(quizProvider.notifier).updateQuestionTime(state);
        
        // If timer reaches 0, move to next question
        if (state == 0) {
          timer.cancel();
          ref.read(quizProvider.notifier).nextQuestion();
          // Reset timer for next question
          if (!ref.read(quizProvider).quizCompleted) {
            state = 30;
            startTimer();
          }
        }
      }
    });
  }
void resetTimer() {
  _timer?.cancel();        // Stop previous timer
  state = 30;              // Reset to 30 seconds
  startTimer();            // Start new timer
}


  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

class TotalTimerNotifier extends StateNotifier<int> {
  final Ref ref;
  Timer? _timer;

  TotalTimerNotifier(this.ref) : super(0);

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state > 0) {
        state--;
        ref.read(quizProvider.notifier).updateTotalTime(state);

        if (state == 0) {
          timer.cancel();
          ref.read(quizProvider.notifier).state =
              ref.read(quizProvider).copyWith(quizCompleted: true);
        }
      }
    });
  }

  void resetTimer(int totalTime) {
    _timer?.cancel();
    state = totalTime;
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}