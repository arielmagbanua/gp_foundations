part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class Authenticated extends AuthenticationState {
  final User user;

  Authenticated(this.user);

  @override
  List<Object> get props => [
        user,
      ];
}

class Unauthenticated extends AuthenticationState {
  @override
  List<Object?> get props => [];
}
