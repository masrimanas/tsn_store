part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLoadStatus extends AuthEvent {
  const AuthLoadStatus();

  @override
  List<Object> get props => [];
}

class AuthLoginPressed extends AuthEvent {
  final User user;
  const AuthLoginPressed({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}

class AuthLogoutPressed extends AuthEvent {
  const AuthLogoutPressed();

  @override
  List<Object> get props => [];
}
