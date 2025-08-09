import 'package:flutter/material.dart';
import 'package:psc_learner/core/constants/colors.dart';
import 'package:psc_learner/core/constants/text_style.dart';

class Currentaffairwidget extends StatelessWidget {
  const Currentaffairwidget({super.key});

  @override
  Widget build(BuildContext context) {
      const title = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do';
    const subtitle = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
        'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
        'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris. '
        'This is a very long subtitle text that should wrap properly.';
    return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image container
                Container(
                  width: 120,
                  height: 130,
                  color: Colors.blueGrey,
                  margin: const EdgeInsets.only(right: 12),
                ),
                // Text content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: KtextStyle.roboto.copyWith(
                          fontSize: 16,
                          color: buttonWhite,
                          fontWeight: FontWeight.bold,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                      const SizedBox(height: 6), // Add spacing between title and subtitle
                      Text(
                        subtitle,
                        style: KtextStyle.roboto.copyWith(
                          fontSize: 14,
                          color: const Color.fromARGB(255, 178, 175, 175).withOpacity(0.8),
                        ),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    ],
                  ),
                  
                ),
              
              ],
            ),
          );
  }
}