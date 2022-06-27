import 'package:tsn_store/domain/repositories/product_repository.dart';

import '../entities/product.dart';

class GetProducts {
  final ProductRepository repository;
  GetProducts(
    this.repository,
  );
  Future<List<Product>> execute() async {
    return repository.getProducts();
  }
}
