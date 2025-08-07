import 'package:go_router/go_router.dart';
import 'package:psc_learner/features/auth/screens/login/screens/foreget_screen.dart';
import 'package:psc_learner/features/auth/screens/login/screens/verfication_screen.dart';
import 'package:psc_learner/features/entryPoint/entry_point.dart';
import 'package:psc_learner/features/learn/learn_screen.dart';
import 'package:psc_learner/features/auth/screens/login/screens/login_screen.dart';
import 'package:psc_learner/features/auth/screens/sign_up/screens/sign_up_screen.dart';
import 'package:psc_learner/features/splash/splah_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => NoTransitionPage(child: SplashScreen()),
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => NoTransitionPage(child: LoginScreen()),
    ),
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) => NoTransitionPage(child: LearnScreen()),
    ),
    GoRoute(
      path: '/signUp',
      pageBuilder: (context, state) => NoTransitionPage(child: SignUpScreen()),
    ),
    GoRoute(
      path: '/foregetScreen',
      pageBuilder: (context, state) => NoTransitionPage(child: ForgetScreen()),
    ),
    GoRoute(
      path: '/verification',
      pageBuilder: (context, state) =>
          NoTransitionPage(child: VerificationScreen()),
    ),
    GoRoute(
      path: '/entry',
      pageBuilder: (context, state) => NoTransitionPage(child: EntryPoint()),
    ),
  ],
);
