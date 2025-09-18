import 'package:flutter/material.dart';
import 'package:psc_learner/core/constants/colors.dart';
import 'package:psc_learner/core/constants/text_style.dart';
import 'package:psc_learner/core/utils/utils.dart';
import 'package:psc_learner/widgets/qusPage.dart';

class SubjectsWisecards extends StatelessWidget {
  final AssetImage image;
  final String title;
  final String sub;

  const SubjectsWisecards({
    super.key,
    required this.image,
    required this.title,
    required this.sub,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQueryValues(context);

    return GestureDetector(
      onTap: () {
        // Navigate to QuestionsPage with the title
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => QuestionsPage(title: title),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with title and subject tag
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: KtextStyle.subHeadings.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: buttonWhite,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: bgcolor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: bgcolor.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      sub,
                      style: KtextStyle.answerStyle.copyWith(
                        color: buttonWhite,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Image card with minimal styling
            Center(
              child: Container(
                height: mq.height * 0.16,
                width: mq.width * 0.93,
                decoration: BoxDecoration(
                  color: lightWhite.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: lightWhite.withOpacity(0.3),
                    width: 1,
                  ),
                  image: DecorationImage(image: image, fit: BoxFit.fitWidth),
                ),
                child: Stack(
                  children: [
                    // Subtle overlay
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: kblack.withOpacity(0.02),
                      ),
                    ),

                    // Action indicator
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: buttonWhite.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: bgcolor,
                          size: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
