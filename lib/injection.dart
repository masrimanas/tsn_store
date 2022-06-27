import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:tsn_store/data/datasources/firebase.dart';
import 'package:tsn_store/data/models/user_model.dart';
import 'package:tsn_store/data/repositories/product_repository_impl.dart';

import 'package:tsn_store/domain/repositories/product_repository.dart';
import 'package:tsn_store/domain/repositories/user_repository.dart';
import 'package:tsn_store/domain/usecases/get_product.dart';
import 'package:tsn_store/domain/usecases/log_in_user.dart';
import 'package:tsn_store/domain/usecases/sign_up_user.dart';

import 'data/models/product_model.dart';
import 'data/repositories/user_repository_impl.dart';
import 'domain/usecases/log_out_user.dart';
import 'presentation/blocs/auth_bloc/auth_bloc.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(
    () => AuthBloc(
      locator(),
      locator(),
    ),
  );

  // use cases
  locator.registerLazySingleton(() => LogInUser(locator()));
  locator.registerLazySingleton(() => LogOutUser(locator()));
  locator.registerLazySingleton(() => SignUpUser(locator()));
  locator.registerLazySingleton(() => GetProducts(locator()));

  // model
  locator.registerLazySingleton(() => UserModel());
  locator.registerLazySingleton(() => ProductModel());

  // repository
  locator.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
        locator(),
        locator(),
      ));
  locator.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
        locator(),
      ));

  // helper
  locator.registerLazySingleton<FirebaseHelper>(() => FirebaseHelper(
        locator(),
        FirebaseFirestore.instance,
        FirebaseAuth.instance,
      ));

  // // external
  // locator.registerLazySingleton(() => FirebaseAuth());
  // locator.registerLazySingleton(() => FirebaseFirestore());
}
