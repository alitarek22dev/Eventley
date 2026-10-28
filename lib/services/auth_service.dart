import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../core/app_strings.dart';

class AuthService {
  final FirebaseAuth? authInstance;
  final GoogleSignIn? googleSignInInstance;
  final User? currentUserOverride;
  final String? userNameOverride;
  final String? userEmailOverride;

  AuthService({
    this.authInstance,
    this.googleSignInInstance,
    this.currentUserOverride,
    this.userNameOverride,
    this.userEmailOverride,
  });

  FirebaseAuth get auth => authInstance ?? FirebaseAuth.instance;
  GoogleSignIn get googleSignIn => googleSignInInstance ?? GoogleSignIn();

  User? get currentUser {
    if (currentUserOverride != null) return currentUserOverride;
    try {
      return auth.currentUser;
    } catch (_) {
      return null;
    }
  }

  String? get currentUserName => userNameOverride ?? currentUser?.displayName;
  String? get currentUserEmail => userEmailOverride ?? currentUser?.email;

  Stream<User?> get authStateChanges => auth.authStateChanges();

  Future<UserCredential?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  Future<UserCredential?> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential = await auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    if (credential.user != null && name.trim().isNotEmpty) {
      await credential.user!.updateDisplayName(name.trim());
    }

    return credential;
  }

  Future<void> sendPasswordResetEmail({
    required String email,
  }) async {
    await auth.sendPasswordResetEmail(
      email: email.trim(),
    );
  }

  Future<UserCredential?> signInWithGoogle() async {
    if (kIsWeb) {
      final googleProvider = GoogleAuthProvider();
      return await auth.signInWithPopup(googleProvider);
    } else {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw FirebaseAuthException(
          code: 'sign_in_canceled',
          message: 'Google Sign-In was cancelled by the user.',
        );
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await auth.signInWithCredential(credential);
    }
  }

  Future<void> signOut() async {
    await Future.wait([
      auth.signOut(),
      if (!kIsWeb) googleSignIn.signOut(),
    ]);
  }

  String getErrorMessage(dynamic error, AppStrings strings) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'email-already-in-use':
          return strings.emailAlreadyInUse;
        case 'weak-password':
          return strings.weakPassword;
        case 'user-not-found':
          return strings.userNotFound;
        case 'wrong-password':
          case 'invalid-credential':
        case 'invalid-email':
          return strings.invalidEmailOrPassword;
        case 'user-disabled':
          return strings.userDisabled;
        case 'too-many-requests':
          return strings.tooManyRequests;
        case 'network-request-failed':
          return strings.networkError;
        case 'sign_in_canceled':
          return strings.googleSignInCancelled;
        default:
          return error.message ?? strings.authenticationFailed;
      }
    }
    return strings.authenticationFailed;
  }
}
