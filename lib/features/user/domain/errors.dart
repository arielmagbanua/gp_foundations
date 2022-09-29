/// Thrown if during the sign up process if a failure occurs.
class SignUpFailure implements Exception {
  final String message;

  SignUpFailure([this.message = '']);
}

/// Thrown during the cancellation of google sign-in.
class LogInWithGoogleCancelledFailure implements Exception {}

/// Thrown during the sign in with google process if a failure occurs.
class LogInWithGoogleFailure implements Exception {
  final String message;

  LogInWithGoogleFailure({this.message = ''});
}

/// Thrown during the login process if a failure occurs.
class LogInWithEmailAndPasswordFailure implements Exception {}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}
