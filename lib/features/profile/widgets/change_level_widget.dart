
import 'package:flutter/material.dart';
import 'package:psc_learner/core/constants/colors.dart';
import 'package:psc_learner/core/constants/text_style.dart';
import 'package:psc_learner/core/utils/utils.dart';
import 'package:psc_learner/features/profile/widgets/dropDownWidget.dart';

class ChngeLevelRow extends StatelessWidget {
  const ChngeLevelRow({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQueryValues(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'Change your Syllubus',
          style: KtextStyle.answerStyle.copyWith(
            color: const Color.fromARGB(255, 188, 207, 189),
          ),
        ),
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => Dialog(
                backgroundColor: const Color.fromARGB(255, 123, 158, 131),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                insetPadding: const EdgeInsets.symmetric(horizontal: 40),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Before selecting a syllabus, please note:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: buttonWhite,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.black.withOpacity(0.5),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "• Your content will align based on your selected level.",
                                  style: TextStyle(color: buttonWhite),
                                ),
                                Text(
                                  "• Make sure to choose the correct syllabus.",
                                  style: TextStyle(color: buttonWhite),
                                ),
                                Text(
                                  "• You can change it anytime later.",
                                  style: TextStyle(color: buttonWhite),
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            indent: 24,
                            endIndent: 24,
                            color: Color.fromARGB(255, 79, 75, 75),
                          ),

                          Center(
                            child: Text(
                              'view what the specific jobs',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              iconViewLecelsJobs('SSLC', () {
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
                              iconViewLecelsJobs('PLUS TWO', () {
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
                              iconViewLecelsJobs('DEGREE', () {
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
                          const Divider(
                            indent: 24,
                            endIndent: 24,
                            color: Color.fromARGB(255, 79, 75, 75),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: SizedBox(width: 160, child: Dropdownwidget()),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },

          icon: Icon(Icons.fingerprint, color: Colors.green, size: 31),
        ),
      ],
    );
  }
}

Widget iconViewLecelsJobs(String title, VoidCallback onclick) {
  return Column(
    children: [
      IconButton(
        onPressed: onclick,
        icon: Icon(
          Icons.school,
          color: const Color.fromARGB(255, 32, 42, 32),
          size: 29,
        ),
      ),
      Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
    ],
  );
}

void showSyllabusBottomSheet(
  BuildContext context,
  String title,
  List<String> syllubus,
) {
  showModalBottomSheet(
    context: context,

    backgroundColor: bgcolor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
    ),
    builder: (context) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Jobs available for $title level',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: buttonWhite,
                ),
              ),
              const SizedBox(height: 10),
              ...syllubus.map(
                (items) => ListTile(
                  title: Text(
                    items,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 166, 166, 166),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
