part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthStateNone extends AuthState {
  const AuthStateNone();
  @override
  List<Object> get props => [];
}

class AuthStateLoading extends AuthState {
  const AuthStateLoading();
  @override
  List<Object> get props => [];
}

class AuthStateSuccess extends AuthState {
  final User user;

  const AuthStateSuccess(
    this.user,
  );
  @override
  List<Object> get props => [user];
}

class AuthStateFailure extends AuthState {
  final String message;

  const AuthStateFailure(
    this.message,
  );
  @override
  List<Object> get props => [message];
}

extension AuthStates on AuthState {
  User get user => this is AuthStateSuccess
      ? (this as AuthStateSuccess).user
      : User(id: 'id', email: 'email');
}
