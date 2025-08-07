// bismillahirrahmanirrahim

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:psc_learner/core/constants/colors.dart';
import 'package:psc_learner/firebase_options.dart';
import 'package:psc_learner/routes/app_routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

// sahared prefrence
late SharedPreferences prefs;

void main() async {
  // this is required to initiallize Firebase before running the app
  // otherwise it will throw an error
  // its a way to start engine of the app / flutter
  WidgetsFlutterBinding.ensureInitialized();
  // logining to firebase service
  // this is required to initialize Firebase before running the app
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  prefs = await SharedPreferences.getInstance();
  // provider scope is required to use riverpod
  // its a way to app put to a tool box that we can use tool (provider) from anywhere in the app
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
