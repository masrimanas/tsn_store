import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:tsn_store/data/datasources/firebase.dart';
import 'package:tsn_store/data/models/user_model.dart';
import 'package:tsn_store/domain/repositories/user_repository.dart';

import '../../domain/entities/user.dart';
import '../../utils/failure.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseHelper _auth;
  final UserModel _userModel;

  const UserRepositoryImpl(
    this._auth,
    this._userModel,
  );

  @override
  Future<Either<Failure, void>> signUpUser(User user) async {
    try {
      await _auth.signUpUser(UserModel.fromEntity(user));

      return Right(log('SignUp Success'));
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> logInUser(User user) async {
    try {
      final response = await _auth.logInUser(UserModel.fromEntity(user));
      return Right(_userModel.fromAuth(response!.user!));
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logOutUser() async {
    try {
      await _auth.logOutUser();
      return Right(log('SignOut Success'));
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
