import 'package:flutter/material.dart';
import 'package:psc_learner/core/constants/colors.dart';
import 'package:psc_learner/core/constants/text_style.dart';

class UpgradeProWidget extends StatelessWidget {
  const UpgradeProWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Upgrade to pro',
            style: KtextStyle.roboto.copyWith(color: buttonWhite),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 26),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 55, 61, 55),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Go to Subscription page',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                   
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
