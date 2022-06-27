import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tsn_store/domain/repositories/product_repository.dart';

import '../entities/user.dart';

class LoadProduct {
  ProductRepository repository;
  LoadProduct(
    this.repository,
  );
  Stream<QuerySnapshot<Map<String, dynamic>>> execute(User user) {
    return repository.loadCart(user);
  }
}
