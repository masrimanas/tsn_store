import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tsn_store/data/datasources/firebase.dart';

import '../../domain/entities/product.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  ProductRepositoryImpl(
    this._db,
  );

  final FirebaseHelper _db;

  @override
  Future<List<Product>> getProducts() async {
    try {
      final result = await _db.getProducts();
      final data = result.map((data) => data.toEntity()).toList();
      return data;
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<void> addToCart(Product product, User user) async {
    try {
      await _db.addToCart(product, user);
    } on Exception {
      rethrow;
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> loadCart(User user) async* {
    try {
      final data = _db.loadCart(user);
      yield* data;
    } on Exception {
      rethrow;
    }
  }
}
