import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/// User
///
/// The user model class
@JsonSerializable()
class User {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  bool verified = false;

  /// Constructor
  ///
  /// The [id] is the id of the user.
  /// The [email] is the email of the user.
  /// The [firstName] is the first name of the user.
  /// The [lastName] is the last name of the user.
  User(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      this.verified = false});

  /// Creates a user from json data structure.
  ///
  /// The [json] is the json structure of the user.
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Converts this user to a json.
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
