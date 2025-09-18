import 'package:flutter/material.dart';
import 'package:psc_learner/core/constants/colors.dart';
import 'package:psc_learner/core/constants/text_style.dart';
import 'package:psc_learner/features/profile/widgets/dropDownWidget.dart';

class ChngeLevelRow extends StatelessWidget {
  const ChngeLevelRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color.fromARGB(255, 188, 207, 189).withOpacity(0.1),
            const Color.fromARGB(255, 123, 158, 131).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color.fromARGB(255, 188, 207, 189).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            'Change your Syllabus',
            style: KtextStyle.answerStyle.copyWith(
              color: const Color.fromARGB(255, 188, 207, 189),
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Colors.green.shade400,
                  Colors.green.shade600,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: IconButton(
              onPressed: () => _showSyllabusDialog(context),
              icon: const Icon(
                Icons.fingerprint_rounded,
                color: Colors.white,
                size: 28,
              ),
              padding: const EdgeInsets.all(12),
            ),
          ),
        ],
      ),
    );
  }

  void _showSyllabusDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color.fromARGB(255, 123, 158, 131),
                const Color.fromARGB(255, 100, 140, 110),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.info_outline,
                        color: buttonWhite,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Before selecting a syllabus',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: buttonWhite,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      _buildInfoItem("Content aligns with your selected level", Icons.check_circle_outline),
                      const SizedBox(height: 12),
                      _buildInfoItem("Choose the correct syllabus carefully", Icons.warning_outlined),
                      const SizedBox(height: 12),
                      _buildInfoItem("You can change it anytime later", Icons.refresh_outlined),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'View available jobs by level',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: buttonWhite,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _enhancedIconViewLevelsJobs('SSLC', Icons.school_outlined, () {
                            Navigator.pop(context);
                            showSyllabusBottomSheet(context, 'SSLC', [
                              "Last Grade Servant (LGS)",
                              "Office Attendant",
                              "Peon / Watchman",
                              "Village Field Assistant (VFA)",
                              "Driver (various departments)",
                              "Clerk (SSLC category)",
                              "Store Keeper (basic category)",
                              "Attender (schools, offices)",
                              "Police Constable (SSLC batches)",
                              "Binder / Duplicator Operator",
                              "Lift Operator",
                              "Laboratory Attender",
                              "Boat Lascar",
                              "Process Server",
                              "Pump Operator",
                              "Syrang",
                              "Cleaner",
                              "Mechanic Helper",
                              "Hospital Attendant",
                              "Other Category 1 SSLC qualification posts",
                            ]);
                          }),
                          _enhancedIconViewLevelsJobs('PLUS TWO', Icons.school, () {
                            Navigator.pop(context);
                            showSyllabusBottomSheet(context, 'PLUS TWO', [
                              "Civil Excise Officer",
                              "Forest Guard",
                              "Forest Beat Officer",
                              "Assistant Prison Officer",
                              "Typist / Clerk (Higher Secondary)",
                              "Data Entry Operator",
                              "Fireman / Firewoman (Trainee)",
                              "Police Constable (APB – +2 batches)",
                              "Company / Co-operative Society Clerk",
                              "Village Extension Officer (VEO)",
                              "Beat Forest Officer",
                              "Computer Assistant Grade II",
                              "Lower Division Clerk (LDC) – +2 category",
                              "Store Keeper (HS category)",
                              "Assistant Grade II (boards & corporations)",
                              "Telephone Operator",
                              "Tradesman Instructor (HS category)",
                              "Other Category 2 +2 qualification posts",
                            ]);
                          }),
                          _enhancedIconViewLevelsJobs('DEGREE', Icons.school_rounded, () {
                            Navigator.pop(context);
                            showSyllabusBottomSheet(context, 'DEGREE', [
                              "Secretariat Assistant",
                              "Sub Inspector of Police (SI)",
                              "Excise Inspector",
                              "Junior Assistant (boards & corporations)",
                              "ICDS Supervisor",
                              "Company / Co-operative Society Assistant",
                              "Block Panchayat Secretary",
                              "Municipal Secretary (Grade III)",
                              "Revenue Inspector",
                              "Assistant Jailor",
                              "Assistant Grade II (Degree category)",
                              "Research Assistant",
                              "Statistical Assistant",
                              "Welfare Officer",
                              "Development Officer",
                              "Public Relations Officer",
                              "Translator",
                              "Junior Employment Officer",
                              "Other Category 3 Degree qualification posts",
                            ]);
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: const Dropdownwidget(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(String text, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color.fromARGB(255, 144, 238, 144),
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: buttonWhite,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}

Widget _enhancedIconViewLevelsJobs(String title, IconData icon, VoidCallback onclick) {
  return GestureDetector(
    onTap: onclick,
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 32, 42, 32),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: buttonWhite,
              fontSize: 12,
            ),
          ),
        ],
      ),
    ),
  );
}

void showSyllabusBottomSheet(
  BuildContext context,
  String title,
  List<String> syllabus,
) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              bgcolor,
              bgcolor.withOpacity(0.9),
            ],
          ),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.work_outline,
                      color: buttonWhite,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Jobs available for $title level',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: buttonWhite,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: syllabus.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 144, 238, 144),
                          shape: BoxShape.circle,
                        ),
                      ),
                      title: Text(
                        syllabus[index],
                        style: const TextStyle(
                          color: Color.fromARGB(255, 200, 200, 200),
                          fontSize: 15,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
