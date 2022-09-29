import '../../domain/entities/user.dart' as entities;
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

/// User
///
/// The data model for a foundations user.
class User extends entities.User {
  User({
    required super.id,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.gender,
    super.verified = false,
  });
}

/// Extend or add function for a User.
extension FirebaseUserExtensions on firebase_auth.User {
  /// Converts firebase user to User.
  ///
  /// The [gender] is the gender of the user.
  User toUser([String gender = '']) {
    String firstName = '';
    String lastName = '';

    if (displayName != null && displayName!.isNotEmpty) {
      final fullName = displayName!.split(' ');

      firstName = fullName[0];
      lastName = fullName[1];
    }

    return User(
      id: uid,
      firstName: firstName,
      lastName: lastName,
      email: email!,
      gender: gender,
      verified: emailVerified,
    );
  }
}
