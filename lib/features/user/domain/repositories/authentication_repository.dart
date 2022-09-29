import '../entities/user.dart';

/// AuthenticationRepository
///
/// It is the contract / interface for abstracting the underlying implementation
/// of how a user is authenticated as well as how a user is fetched.
abstract class AuthenticationRepository {
  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  Stream<User?> get user;

  /// The current authenticated user.
  User? get currentUser;

  /// Signs up a user.
  ///
  /// The [firstName] is the first name of the user.
  /// The [lastName] is the last name of the user.
  /// The [email] is the email of the user.
  /// The [password] is the password provided the user.
  /// The [gender] is the gender of the user.
  /// The [verified] indicates if the user is verified or not.
  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String gender,
    bool verified = false,
  });

  /// Sends email verification to the current user.
  Future<void> sendEmailVerification();

  /// Starts the Sign In with Google Flow.
  Future<void> loginWithGoogle();

  /// Signs in with the provided [email] and [password].
  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Signs out the current user which will emit.
  Future<void> logOut();

  /// Reset the password of the user.
  ///
  /// The [email] is the email of the user that needs the reset link.
  Future<void> sendResetPasswordLinkEmail(String email);

  /// Confirms the password reset
  ///
  /// The [actionCode] is the action code of the reset password deep link.
  /// The [password] is the new password of the user.
  Future<void> confirmPasswordReset(String actionCode, String newPassword);
}
