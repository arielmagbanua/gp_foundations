import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gp_foundations/features/user/domain/entities/user.dart';

part 'authentication_state.dart';

/// AuthenticationCubit
///
/// The cubit class for user.
class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(Unauthenticated());

  /// Emit a state that the authenticated user was changed.
  ///
  /// The [user] is the instance of the current user.
  void authenticatedUserChanged(User user) {
    emit(Authenticated(user));
  }

  /// Emit a state where the current user was logged out.
  void logoutCurrentUser() {
    emit(Unauthenticated());
  }
}
