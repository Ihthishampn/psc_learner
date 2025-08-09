import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:psc_learner/core/constants/colors.dart';
import 'package:psc_learner/features/profile/providers/provider_sort.dart';

class StatsWidget extends ConsumerWidget {
  const StatsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final levelProviderGet = ref.watch(levelProvider);
    return statsWidgethere(levelProviderGet,context);
  }
}

Widget statsWidgethere(Enum level,BuildContext context) {
  if (level == Level.sslc) {
    return Padding(
      padding: const EdgeInsets.all(11.0),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: lightWhite,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 6),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'STATS  sslc',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(endIndent: 12, indent: 12),
             SizedBox(height: MediaQuery.of(context).size.height *0.012),
            Text(
              'Latest test :',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'correct :   56',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.green,
                  ),
                ),
                Text(
                  'wrong :   12',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
             SizedBox(height: MediaQuery.of(context).size.height *0.01),
            Text(
              'Completed Qus : 68',
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(endIndent: 12, indent: 12),

            Center(
              child: Text(
                'Your 5 highest score',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
             SizedBox(height: MediaQuery.of(context).size.height *0.02),
            Text(
              ' corrrect : 34 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
            Text(
              ' wrong : 12 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.redAccent,
              ),
            ),
            Text(
              ' complted : 46 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blueAccent,
              ),
            ),
            Divider(endIndent: 12, indent: 12),
            Text(
              ' corrrect : 34 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
            Text(
              ' wrong : 12 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.redAccent,
              ),
            ),
            Text(
              ' complted : 46 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blueAccent,
              ),
            ),
            Divider(endIndent: 12, indent: 12),
            Text(
              ' corrrect : 34 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
            Text(
              ' wrong : 12 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.redAccent,
              ),
            ),
            Text(
              ' complted : 46 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blueAccent,
              ),
            ),
            Divider(endIndent: 12, indent: 12),
            Text(
              ' corrrect : 34 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
            Text(
              ' wrong : 12 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.redAccent,
              ),
            ),
            Text(
              ' complted : 46 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blueAccent,
              ),
            ),
            Divider(endIndent: 12, indent: 12),
            Text(
              ' corrrect : 34 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
            Text(
              ' wrong : 12 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.redAccent,
              ),
            ),
            Text(
              ' complted : 46 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blueAccent,
              ),
            ),
            Divider(endIndent: 12, indent: 12),
          ],
        ),
      ),
    );
  } else if (level == Level.plusTwo) {
    return Padding(
      padding: const EdgeInsets.all(11.0),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color.fromARGB(222, 44, 64, 90),
          borderRadius: BorderRadius.circular(12),
         
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'STATS  +2',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold,color: buttonWhite),
              ),
            ),
            const Divider(endIndent: 12, indent: 12),
             SizedBox(height: MediaQuery.of(context).size.height *0.012),
            Text(
              'Latest test :',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: buttonWhite),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'correct :   56',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.green,
                  ),
                ),
                Text(
                  'wrong :   12',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
             SizedBox(height: MediaQuery.of(context).size.height *0.01),
            Text(
              'Completed Qus : 68',
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(endIndent: 12, indent: 12),

            Center(
              child: Text(
                'Your 5 highest score',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: buttonWhite),
              ),
            ),
             SizedBox(height: MediaQuery.of(context).size.height *0.02),
            Text(
              ' corrrect : 34 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
            Text(
              ' wrong : 12 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.redAccent,
              ),
            ),
            Text(
              ' complted : 46 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blueAccent,
              ),
            ),
            Divider(endIndent: 12, indent: 12),
            Text(
              ' corrrect : 34 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
            Text(
              ' wrong : 12 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.redAccent,
              ),
            ),
            Text(
              ' complted : 46 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blueAccent,
              ),
            ),
            Divider(endIndent: 12, indent: 12),
            Text(
              ' corrrect : 34 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
            Text(
              ' wrong : 12 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.redAccent,
              ),
            ),
            Text(
              ' complted : 46 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blueAccent,
              ),
            ),
            Divider(endIndent: 12, indent: 12),
            Text(
              ' corrrect : 34 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
            Text(
              ' wrong : 12 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.redAccent,
              ),
            ),
            Text(
              ' complted : 46 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blueAccent,
              ),
            ),
            Divider(endIndent: 12, indent: 12),
            Text(
              ' corrrect : 34 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
            Text(
              ' wrong : 12 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.redAccent,
              ),
            ),
            Text(
              ' complted : 46 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blueAccent,
              ),
            ),
            Divider(endIndent: 12, indent: 12),
          ],
        ),
      ),
    );
  } else {
    return Padding(
      padding: const EdgeInsets.all(11.0),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: lightWhite,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 6),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'STATS  degree',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(endIndent: 12, indent: 12),
             SizedBox(height: MediaQuery.of(context).size.height *0.012),
            Text(
              'Latest test :',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'correct :   56',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.green,
                  ),
                ),
                Text(
                  'wrong :   12',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
             SizedBox(height: MediaQuery.of(context).size.height *0.01),
            Text(
              'Completed Qus : 68',
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(endIndent: 12, indent: 12),

            Center(
              child: Text(
                'Your 5 highest score',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
             SizedBox(height: MediaQuery.of(context).size.height *0.02),
            Text(
              ' corrrect : 34 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
            Text(
              ' wrong : 12 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.redAccent,
              ),
            ),
            Text(
              ' complted : 46 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blueAccent,
              ),
            ),
            Divider(endIndent: 12, indent: 12),
            Text(
              ' corrrect : 34 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
            Text(
              ' wrong : 12 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.redAccent,
              ),
            ),
            Text(
              ' complted : 46 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blueAccent,
              ),
            ),
            Divider(endIndent: 12, indent: 12),
            Text(
              ' corrrect : 34 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
            Text(
              ' wrong : 12 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.redAccent,
              ),
            ),
            Text(
              ' complted : 46 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blueAccent,
              ),
            ),
            Divider(endIndent: 12, indent: 12),
            Text(
              ' corrrect : 34 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
            Text(
              ' wrong : 12 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.redAccent,
              ),
            ),
            Text(
              ' complted : 46 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blueAccent,
              ),
            ),
            Divider(endIndent: 12, indent: 12),
            Text(
              ' corrrect : 34 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
            Text(
              ' wrong : 12 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.redAccent,
              ),
            ),
            Text(
              ' complted : 46 ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blueAccent,
              ),
            ),
            Divider(endIndent: 12, indent: 12),
          ],
        ),
      ),
    );
  }
}
