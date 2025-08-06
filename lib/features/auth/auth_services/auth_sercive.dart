import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:psc_learner/features/auth/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<UserModel> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userModel = UserModel(
        uid: cred.user!.uid,
        username: username,
        email: email,
      );

      await _firebaseFirestore
          .collection('users')
          .doc(cred.user!.uid)
          .set(userModel.toMap());

      await cred.user!.sendEmailVerification();

      return userModel;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw Exception('This email is already in use. Try logging in.');
        case 'weak-password':
          throw Exception(
            'The password is too weak. Use at least 6 characters.',
          );
        case 'invalid-email':
          throw Exception('Invalid email address.');
        case 'operation-not-allowed':
          throw Exception(
            'Email/password sign-in is disabled. Contact support.',
          );
        case 'user-disabled':
          throw Exception('This user account has been disabled.');
        case 'user-not-found':
          throw Exception('No account found for this email.');
        case 'wrong-password':
          throw Exception('Incorrect password.');
        case 'too-many-requests':
          throw Exception('Too many attempts. Try again later.');
        case 'invalid-credential':
          throw Exception('Invalid credentials provided.');
        case 'account-exists-with-different-credential':
          throw Exception('Account exists with different sign-in method.');
        case 'expired-action-code':
          throw Exception('The email verification/reset link has expired.');
        case 'invalid-action-code':
          throw Exception('Invalid or broken link.');
        case 'missing-email':
          throw Exception('Email is required.');
        case 'internal-error':
          throw Exception('Internal server error. Try again.');
        case 'invalid-verification-code':
          throw Exception('Invalid code. Please check again.');
        case 'invalid-verification-id':
          throw Exception('Invalid verification ID.');
        case 'network-request-failed':
          throw Exception('Network error. Check your connection.');
        default:
          throw Exception('Auth error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  // login login

  Future<String?> login(String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!cred.user!.emailVerified) {
        return 'Please verify your email before logging in';
      }
      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw Exception('This email is already in use. Try logging in.');
        case 'invalid-password':
        case 'weak-password':
          throw Exception(
            'The password is too weak. Use at least 6 characters.',
          );
        case 'invalid-email':
          throw Exception('Invalid email address format.');
        case 'operation-not-allowed':
          throw Exception(
            'Email/password sign-in is disabled. Contact support.',
          );
        case 'user-disabled':
          throw Exception('This user account has been disabled.');
        case 'user-not-found':
          throw Exception('No account found with this email.');
        case 'wrong-password':
          throw Exception('Incorrect password.');
        case 'too-many-requests':
          throw Exception('Too many attempts. Please try again later.');
        case 'invalid-credential':
          throw Exception('Invalid sign-in credentials provided.');
        case 'account-exists-with-different-credential':
          throw Exception(
            'An account already exists with a different sign-in method.',
          );
        case 'expired-action-code':
          throw Exception('This link has expired. Please request a new one.');
        case 'invalid-action-code':
          throw Exception('The link is invalid or broken.');
        case 'missing-email':
          throw Exception('Email field is missing.');
        case 'internal-error':
          throw Exception('Internal server error. Please try again.');
        case 'invalid-verification-code':
          throw Exception('Invalid verification code.');
        case 'invalid-verification-id':
          throw Exception('Invalid verification ID.');
        case 'network-request-failed':
          throw Exception('Network error. Check your internet connection.');
        case 'id-token-expired':
          throw Exception('Session expired. Please log in again.');
        case 'id-token-revoked':
          throw Exception('Session revoked. Please log in again.');
        case 'unauthorized-continue-uri':
          throw Exception('Continue URL not authorized.');
        case 'invalid-continue-uri':
          throw Exception('Invalid continue URL.');
        case 'missing-android-pkg-name':
        case 'missing-ios-bundle-id':
          throw Exception('Missing required app configuration.');
        default:
          throw Exception('Authentication failed: ${e.message}');
      }
    }
  }

  // forget pass word...

  Future<String?> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "No account found with this email";
      } else {
        return "Error: ${e.message}";
      }
    } catch (e) {
      return "Unexpected error: $e";
    }
  }
Future<String> verificationEmailAgain(String email) async {
  try {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null || user.email?.toLowerCase() != email.toLowerCase()) {
      return 'Please log in with this email first.';
    }

    await user.reload(); // ✅ Refresh before checking
    final refreshedUser = FirebaseAuth.instance.currentUser;

    if (refreshedUser?.email == null) {
      return 'No email associated with this account.';
    }

    if (refreshedUser!.emailVerified) {
      return 'Your email is already verified. Please try to login.';
    }

    await refreshedUser.sendEmailVerification();
    return 'Verification email sent. Please check your inbox and spam folder.';
  } catch (e) {
    final error = e.toString();
    if (error.contains('user-not-found')) {
      return 'This email is not registered. Please sign up.';
    }
    return 'Failed to send verification email: $error';
  }
}




}
