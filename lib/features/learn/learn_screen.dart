import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:psc_learner/core/constants/colors.dart';
import 'package:psc_learner/core/constants/images.dart';
import 'package:psc_learner/core/constants/text_style.dart';
import 'package:psc_learner/core/utils/utils.dart';
import 'package:psc_learner/features/learn/widgets/learn_sort_bar.dart';
import 'package:psc_learner/features/learn/widgets/subjects_wiseCards.dart';
import 'package:psc_learner/features/profile/providers/provider_sort.dart';
import 'package:psc_learner/widgets/qusPage.dart';

class LearnScreen extends ConsumerWidget {
  const LearnScreen({super.key});

  Future<String?> getUserName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid) // Use UID as doc ID
        .get();

    if (doc.exists) {
      return doc['username'];
    }
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final levelProviderget = ref.watch(levelProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgcolor,
        title: FutureBuilder<String?>(
          future: getUserName(),
          builder: (context, snapshot) {
            final username =
                snapshot.connectionState == ConnectionState.waiting
                    ? '...'
                    : snapshot.data ?? 'User';

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hi $username 👋,', style: KtextStyle.subHeadings),
                Text(
                  'good luck! Be unique in your own way.',
                  style: KtextStyle.subHeadings.copyWith(fontSize: 13),
                ),
              ],
            );
          },
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 10),
          children: [
            dividerWidget,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _TopIconButton(
                  iconcolor: Colors.green,
                  textcolor: Colors.green,
                  icon: Icons.check_circle,
                  label: 'Complete',
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, _, __) =>
                            const CompleteQuestionsPage(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  },
                ),
                _TopIconButton(
                  textcolor: Colors.yellow,
                  iconcolor: Colors.yellow,
                  icon: Icons.self_improvement,
                  label: 'Improvement',
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, _, __) =>
                            const ImprovementQuestionsPage(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  },
                ),
                _TopIconButton(
                  textcolor: Colors.red,
                  iconcolor: Colors.redAccent,
                  icon: Icons.dangerous,
                  label: 'Crush',
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, _, __) =>
                            const CrushQuestionsPage(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  },
                ),
              ],
            ),
            const LearnSortBar(),
            ..._buildSubjectCards(levelProviderget),
          ],
        ),
      ),
    );
  }
}


  List<Widget> _buildSubjectCards(Enum? level) {
    if (level == Level.sslc) {
      return const [
        SubjectsWisecards(
          sub: '|SSLC|',
          image: keralaRenaissance,
          title: 'Kerala Renaissance',
        ),
        SubjectsWisecards(
          sub: '|SSLC|',

          image: indianHistory,
          title: 'Indian History',
        ),

        SubjectsWisecards(
          sub: '|SSLC|',

          image: geography,
          title: 'Geography (India & Kerala)',
        ),
        SubjectsWisecards(
          sub: '|SSLC|',

          image: indianPolity,
          title: 'Indian Polity',
        ),
        SubjectsWisecards(
          sub: '|SSLC|',

          image: generalScience,
          title: 'General Science',
        ),
        SubjectsWisecards(
          sub: '|SSLC|',

          image: computerKnowldge,
          title: 'Basic Computer Knowledge',
        ),
        SubjectsWisecards(
          sub: '|SSLC|',

          image: arithematic,
          title: 'Simple Arithmetic',
        ),
        SubjectsWisecards(
          sub: '|SSLC|',

          image: english,
          title: 'English Grammar',
        ),
        SubjectsWisecards(
          sub: '|SSLC|',

          image: malayalam,
          title: 'Malayalam Grammar',
        ),
      ];
    } else if (level == Level.plusTwo) {
      return const [
        SubjectsWisecards(
          sub: '|+2|',

          image: keralaRenaissance,
          title: 'Kerala Renaissance',
        ),
        SubjectsWisecards(
          sub: '|+2|',

          image: indianHistory,
          title: 'Indian History',
        ),
        SubjectsWisecards(
          sub: '|+2|',

          image: geography,
          title: 'Indian Geography',
        ),
        SubjectsWisecards(
          sub: '|+2|',

          image: indianPolity,
          title: 'Indian Polity & Constitution',
        ),
        SubjectsWisecards(
          sub: '|+2|',

          image: indianEconomy,
          title: 'Indian Economy',
        ),
        SubjectsWisecards(
          sub: '|+2|',

          image: environmentalScience,
          title: 'Environmental Science',
        ),
        SubjectsWisecards(
          sub: '|+2|',

          image: generalScience,
          title: 'General Science',
        ),
        SubjectsWisecards(
          sub: '|+2|',

          image: arithematic,
          title: 'Simple Arithmetic',
        ),
        SubjectsWisecards(
          sub: '|+2|',

          image: english,
          title: 'English Grammar & Usage ',
        ),
        SubjectsWisecards(
          sub: '|+2|',

          image: malayalam,
          title: 'Malayalam Grammar',
        ),
        SubjectsWisecards(
          sub: '|+2|',

          image: computerKnowldge,
          title: 'Computer Awareness',
        ),
      ];
    } else {
      return [
        SubjectsWisecards(
          image: keralaRenaissance,
          title: 'kerala Renaissance',
          sub: '|DEGREE|',
        ),
        SubjectsWisecards(
          image: modernIndianHistory,
          title: 'Modern Indian History',
          sub: '|DEGREE|',
        ),
        SubjectsWisecards(
          image: indianPolity,
          title: 'Indian Polity & Constitution',
          sub: '|DEGREE|',
        ),
        SubjectsWisecards(
          image: geography,
          title: 'Indian Geography',
          sub: '|DEGREE|',
        ),
        SubjectsWisecards(
          image: indianEconomy,
          title: 'Indian Economy ',
          sub: '|DEGREE|',
        ),
        SubjectsWisecards(
          image: environmentalScience,
          title: 'Environmental Science \n & Ecology ',
          sub: '|DEGREE|',
        ),
        SubjectsWisecards(
          image: generalScience,
          title: 'General Science ',
          sub: '|DEGREE|',
        ),
        SubjectsWisecards(
          image: quantitativeAptitude,
          title: 'Quantitative Aptitude ',
          sub: '|DEGREE|',
        ),
        SubjectsWisecards(
          image: english,
          title: 'English Grammar \n &Comprehension ',
          sub: '|DEGREE|',
        ),

        SubjectsWisecards(
          image: malayalam,
          title: 'Malayalam',
          sub: '|DEGREE|',
        ),
        SubjectsWisecards(
          image: computerKnowldge,
          title: 'Computer & Cyber Awareness',
          sub: '|DEGREE|',
        ),
      ];
    }
  }


class _TopIconButton extends StatelessWidget {
  final IconData icon;
  final Color iconcolor;
  final String label;
  final Color textcolor;
  final VoidCallback onTap;

  const _TopIconButton({
    
    required this.icon,
    required this.label,
    required this.onTap,
    required this.iconcolor, required this.textcolor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, size: 36, color: iconcolor),
          const SizedBox(height: 4),
          Text(label, style:  TextStyle(fontSize: 12,color: textcolor)),
        ],
      ),
    );
  }
}
