// bismillahirrahmanirrahim

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:psc_learner/core/constants/colors.dart';
import 'package:psc_learner/firebase_options.dart';
import 'package:psc_learner/routes/app_routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

// sahared prefrence
late SharedPreferences prefs;

// main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  prefs = await SharedPreferences.getInstance();
  
  await Hive.initFlutter();
  await Hive.openBox<String>('questionStatusBox'); // Hive box for question statuses  
  // Initialize AppState with the saved level
  
  
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override 
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: bgcolor),
      title: 'Psc Learner',
      // its helps to navigate between screens
      // it is a way to define the routes of the app
      routerConfig: router,
    );
  }
}
