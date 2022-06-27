import 'package:cloud_firestore/cloud_firestore.dart';

import '../entities/product.dart';
import '../entities/user.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
  Future<void> addToCart(Product product, User user);
  Stream<QuerySnapshot<Map<String, dynamic>>> loadCart(User user);
}
