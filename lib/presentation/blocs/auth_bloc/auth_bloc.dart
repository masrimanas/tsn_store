import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:tsn_store/domain/usecases/log_in_user.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/usecases/log_out_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
    this._logIn,
    this._logOut,
  ) : super(const AuthStateNone()) {
    on<AuthLoadStatus>(_load);
    on<AuthLoginPressed>(_login);
    on<AuthLogoutPressed>(_logout);
  }

  final LogInUser _logIn;
  final LogOutUser _logOut;

  FutureOr<void> _load(AuthEvent event, Emitter<AuthState> emit) async {
    emit(const AuthStateLoading());
  }

  FutureOr<void> _login(AuthLoginPressed event, Emitter<AuthState> emit) async {
    emit(const AuthStateLoading());
    final result = await _logIn.execute(event.user);

    result.fold((failure) {
      AuthStateFailure(failure.message);
    }, (data) {
      emit(AuthStateSuccess(data));
      log(data.email!);
    });
  }

  FutureOr<void> _logout(AuthEvent event, Emitter<AuthState> emit) async {
    emit(const AuthStateLoading());

    final result = await _logOut.execute();

    result.fold((failure) {
      AuthStateFailure(failure.message);
    }, (data) {
      emit(const AuthStateNone());
    });
  }
}
