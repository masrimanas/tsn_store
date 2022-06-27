import 'package:dartz/dartz.dart';
import 'package:tsn_store/domain/repositories/user_repository.dart';

import '../../utils/failure.dart';

class LogOutUser {
  final UserRepository repository;
  const LogOutUser(
    this.repository,
  );
  Future<Either<Failure, void>> execute() {
    return repository.logOutUser();
  }
}
