import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/// User
///
/// The user model class
@JsonSerializable()
class User extends Equatable {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final bool verified;

  /// Constructor
  ///
  /// The [id] is the id of the user.
  /// The [email] is the email of the user.
  /// The [firstName] is the first name of the user.
  /// The [lastName] is the last name of the user.
  /// The [gender] is the gender of the user.
  /// The [verified] indicates whether the user was verified or not.
  const User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    this.verified = false,
  });

  /// Creates a user from json data structure.
  ///
  /// The [json] is the json structure of the user.
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Converts this user to a json.
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [
    id,
    email,
    firstName,
    lastName,
    gender,
    verified,
  ];
}

/// Extend or add function for a User.
extension FirebaseUserExtensions on firebase_auth.User {
  /// Converts firebase user to User.
  ///
  /// The [gender] is the gender of the user.
  User toUser(String gender) {
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
