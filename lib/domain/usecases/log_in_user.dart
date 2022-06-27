import 'package:dartz/dartz.dart';
import 'package:tsn_store/domain/repositories/user_repository.dart';

import '../../utils/failure.dart';
import '../entities/user.dart';

class LogInUser {
  final UserRepository repository;
  const LogInUser(
    this.repository,
  );
  Future<Either<Failure, User>> execute(User user) {
    return repository.logInUser(user);
  }
}
