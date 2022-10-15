import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';

import '../../domain/errors.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../../../../core/configs.dart';
import '../data_sources/user_remote_data_source.dart';
import '../models/user.dart';

/// AuthenticationRepositoryImplementation
///
/// It is responsible for abstracting the underlying implementation
/// of how a user is authenticated as well as how a user is fetched.
class AuthenticationRepositoryImplementation
    implements AuthenticationRepository {
  /// The firebase auth instance.
  final firebase_auth.FirebaseAuth firebaseAuth;

  /// The Email action code settings instance for building action code settings
  /// for user verification and reset password
  final EmailActionCodeSettings emailActionCodeSettings;

  /// The remote data source instance for user.
  final UserRemoteDataSource userRemoteDataSource;

  /// The current user instance
  late User? _currentUSer = null;

  /// The google sign-in instance.
  final GoogleSignIn googleSignIn;

  /// Constructor
  ///
  /// The [firebaseAuth] is the firebase auth instance.
  /// The [emailActionCodeSettings] is the action code settings for email.
  /// The [userRemoteDataSource] is the remote data source for users.
  /// The [googleSignIn] The google sign-in instance.
  AuthenticationRepositoryImplementation({
    required this.firebaseAuth,
    required this.emailActionCodeSettings,
    required this.userRemoteDataSource,
    required this.googleSignIn,
  });

  /// Retrieves the current user.
  @override
  User? get currentUser => _currentUSer ?? firebaseAuth.currentUser!.toUser();

  /// Reset the password of the user.
  ///
  /// The [actionCode] is the action code of the reset password deep link.
  /// The [password] is the new password of the user.
  @override
  Future<void> confirmPasswordReset(String actionCode, String newPassword) {
    return firebaseAuth.confirmPasswordReset(
      code: actionCode,
      newPassword: newPassword,
    );
  }

  /// Signs out the current user which will emit.
  @override
  Future<void> logOut() async {
    try {
      await Future.wait([
        firebaseAuth.signOut(),
        googleSignIn.signOut(),
      ]);
    } on Exception {
      throw LogOutFailure();
    }
  }

  /// Sends email verification to the current user.
  @override
  Future<void> sendEmailVerification() async {
    final currentFirebaseUser = firebaseAuth.currentUser;

    if (currentFirebaseUser == null) return;

    if (!currentFirebaseUser.emailVerified) {
      final codeSettings = emailActionCodeSettings.createWith(
        email: currentFirebaseUser.email!,
      );

      return currentFirebaseUser.sendEmailVerification(codeSettings);
    }
  }

  /// Send the reset password link email.
  ///
  /// The [email] is the email of the user that needs the reset link.
  @override
  Future<void> sendResetPasswordLinkEmail(String email) {
    final codeSettings = emailActionCodeSettings.createWith(email: email);

    return firebaseAuth.sendPasswordResetEmail(
      email: email,
      actionCodeSettings: codeSettings,
    );
  }

  /// Signs up a user.
  ///
  /// The [firstName] is the first name of the user.
  /// The [lastName] is the last name of the user.
  /// The [email] is the email of the user.
  /// The [password] is the password provided the user.
  /// The [gender] is the gender of the user.
  /// The [verified] indicates if the user is verified or not.
  @override
  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String gender,
    bool verified = false,
  }) async {
    await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // cache the user for good measure
    final firebaseUser = firebaseAuth.currentUser;

    if (firebaseUser != null) _currentUSer = firebaseUser.toUser(gender);
  }

  /// Login using [email] and [password].
  ///
  /// The [email] is the email address of the user.
  /// The [password] is the password of the user.
  @override
  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on Exception {
      throw LogInWithEmailAndPasswordFailure();
    }
  }

  /// Login user with Google account.
  @override
  Future<void> loginWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = firebase_auth.GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // login the user
    var userCredential = await firebase_auth.FirebaseAuth.instance
        .signInWithCredential(credential);
    var firebaseUser = userCredential.user;
    if (firebaseUser != null) _currentUSer = userCredential.user!.toUser();
  }
}
