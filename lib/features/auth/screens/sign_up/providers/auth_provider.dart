import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:psc_learner/features/auth/auth_services/auth_sercive.dart';
import 'package:psc_learner/features/auth/models/user_model.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());
// UserModel	📦 What it returns (output) — your user data
// Map<String, dynamic>	🔑 What it accepts (input) — your email, password, username
final signUpProvider = FutureProvider.family<UserModel, Map<String, dynamic>>((
  ref,
  params,
) async {
  final auth = ref.read(authServiceProvider);
  return auth.signUp(
    email: params['email'],
    password: params['password'],
    username: params['username'],
  );
});

// login

final authServiceProviderLogin = Provider<AuthService>((ref) => AuthService());

final loginProvider = FutureProvider.family<String?, Map<String, dynamic>>((
  ref,
  params,
) async {
  final auth = ref.read(authServiceProviderLogin);

  return await auth.login(params['email'], params['password']);
});

// reset password

final reserpassprovider = FutureProvider.family<String?, String>((ref, email) {
  final auth = ref.read(authServiceProvider);
  return auth.resetPassword(email);
});

// verification email
final verificationProvider = FutureProvider.family<String, String>((ref, email) async {
  final auth = ref.read(authServiceProvider);
  return auth.verificationEmailAgain(email);
});

