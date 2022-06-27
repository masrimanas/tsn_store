import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, void>> signUpUser(User user);
  Future<Either<Failure, User>> logInUser(User user);
  Future<Either<Failure, void>> logOutUser();
}
