import 'package:tsn_store/domain/entities/product.dart';
import 'package:tsn_store/domain/repositories/product_repository.dart';

import '../entities/user.dart';

class AddToCart {
  ProductRepository repository;
  AddToCart(
    this.repository,
  );

  Future<void> execute(Product product, User user) {
    return repository.addToCart(product, user);
  }
}
