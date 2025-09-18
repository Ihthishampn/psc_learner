import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:psc_learner/core/constants/colors.dart';
import 'package:psc_learner/core/constants/text_style.dart';

class CurrentAffairs extends ConsumerWidget {
  const CurrentAffairs({super.key});

  // Static questions data
  static final List<Map<String, dynamic>> staticQuestions = [
    {
      'question': 'Who is the current Chief Minister of Kerala?',
      'options': ['Pinarayi Vijayan', 'Oommen Chandy', 'V.S. Achuthanandan', 'Ramesh Chennithala'],
      'correctAnswer': 0,
      'category': 'Kerala Politics'
    },
    {
      'question': 'Which Indian state recently launched the "One Nation One Ration Card" scheme nationwide?',
      'options': ['Tamil Nadu', 'Kerala', 'Andhra Pradesh', 'All states implemented'],
      'correctAnswer': 3,
      'category': 'National Policy'
    },
    {
      'question': 'The G20 Summit 2023 was hosted by which country?',
      'options': ['Indonesia', 'India', 'Italy', 'Saudi Arabia'],
      'correctAnswer': 1,
      'category': 'International Affairs'
    },
    {
      'question': 'Which space mission successfully landed on the Moon\'s south pole in 2023?',
      'options': ['Chandrayaan-2', 'Chandrayaan-3', 'Artemis I', 'Luna-25'],
      'correctAnswer': 1,
      'category': 'Science & Technology'
    },
    {
      'question': 'The newest Indian state formed in 2019 is:',
      'options': ['Telangana', 'Jammu and Kashmir', 'Ladakh', 'Uttarakhand'],
      'correctAnswer': 2,
      'category': 'Indian Geography'
    },
    {
      'question': 'Who won the Nobel Peace Prize in 2023?',
      'options': ['Narges Mohammadi', 'Maria Ressa', 'Dmitry Muratov', 'World Food Programme'],
      'correctAnswer': 0,
      'category': 'Awards & Recognition'
    },
    {
      'question': 'The Indian economy is expected to become the world\'s _____ largest economy by 2027:',
      'options': ['Second', 'Third', 'Fourth', 'Fifth'],
      'correctAnswer': 1,
      'category': 'Indian Economy'
    },
    {
      'question': 'Which Indian city hosted the 2023 Chess Olympiad?',
      'options': ['Chennai', 'Mumbai', 'Delhi', 'Bangalore'],
      'correctAnswer': 0,
      'category': 'Sports'
    },
    {
      'question': 'The "Atmanirbhar Bharat" initiative focuses on:',
      'options': ['Digital India', 'Self-reliant India', 'Clean India', 'Skilled India'],
      'correctAnswer': 1,
      'category': 'Government Schemes'
    },
    {
      'question': 'Which river is known as the "Ganga of the South"?',
      'options': ['Kaveri', 'Godavari', 'Krishna', 'Tungabhadra'],
      'correctAnswer': 1,
      'category': 'Geography'
    },
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allQuestions = staticQuestions; // Directly use static questions

    return Container(
      decoration: BoxDecoration(color: bgcolor),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Header Section
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [bgcolor, bgcolor.withOpacity(0.8)],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: bgcolor.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: buttonWhite.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.newspaper,
                      color: buttonWhite,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Affairs',
                          style: KtextStyle.roboto.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: buttonWhite,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Stay updated with latest questions',
                          style: KtextStyle.roboto.copyWith(
                            fontSize: 14,
                            color: buttonWhite.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: buttonWhite.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${allQuestions.length} Questions',
                      style: KtextStyle.roboto.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: buttonWhite,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Questions List
          allQuestions.isEmpty
              ? SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.quiz_outlined,
                          size: 64,
                          color: lightWhite,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "No questions found.",
                          style: KtextStyle.roboto.copyWith(
                            color: kblack.withOpacity(0.6),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final q = allQuestions[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        child: Card(
                          elevation: 2,
                          shadowColor: kblack.withOpacity(0.1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Question Header
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: bgcolor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        'Q${index + 1}',
                                        style: KtextStyle.roboto.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: bgcolor,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    if (q['category'] != null)
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: softblue.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          q['category'],
                                          style: KtextStyle.roboto.copyWith(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: kbluehard,
                                          ),
                                        ),
                                      ),
                                    const Spacer(),
                                    Icon(
                                      Icons.bookmark_outline,
                                      size: 18,
                                      color: lightWhite,
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 12),

                                // Question Text
                                Text(
                                  q['question'] ?? '',
                                  style: KtextStyle.roboto.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: kblack,
                                    height: 1.4,
                                  ),
                                ),

                                const SizedBox(height: 16),

                                // Options
                                if (q['options'] != null)
                                  ...List.generate(
                                    (q['options'] as List).length,
                                    (optIndex) => Container(
                                      margin: const EdgeInsets.only(bottom: 8),
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: lightWhite.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: lightWhite.withOpacity(0.3),
                                          width: 1,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              color: q['correctAnswer'] == optIndex
                                                  ? softblue.withOpacity(0.3)
                                                  : Colors.transparent,
                                              borderRadius: BorderRadius.circular(4),
                                              border: Border.all(
                                                color: lightWhite,
                                                width: 1,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                String.fromCharCode(65 + optIndex),
                                                style: KtextStyle.roboto.copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: q['correctAnswer'] == optIndex ? kbluehard : kblack,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Text(
                                              q['options'][optIndex],
                                              style: KtextStyle.roboto.copyWith(
                                                fontSize: 14,
                                                color: kblack.withOpacity(0.8),
                                                fontWeight: q['correctAnswer'] == optIndex
                                                    ? FontWeight.w600
                                                    : FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          if (q['correctAnswer'] == optIndex)
                                            Icon(
                                              Icons.check_circle_outline,
                                              size: 18,
                                              color: softblue,
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
                    },
                    childCount: allQuestions.length,
                  ),
                ),

          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}
