import 'package:dartz/dartz.dart';
import 'package:tsn_store/domain/repositories/user_repository.dart';

import '../../utils/failure.dart';
import '../entities/user.dart';

class SignUpUser {
  final UserRepository repository;
  const SignUpUser(
    this.repository,
  );
  Future<Either<Failure, void>> execute(User user) {
    return repository.signUpUser(user);
  }
}
