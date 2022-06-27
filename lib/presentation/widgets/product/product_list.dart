import 'package:flutter/material.dart';
import 'package:tsn_store/presentation/pages/product_detail_page.dart';
import 'package:tsn_store/utils/formatter.dart';

import '../../../domain/entities/product.dart';

class ProductList extends StatelessWidget {
  final List<Product> products;
  const ProductList({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: products.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailPage.route,
                      arguments: products[index]);
                },
                child: Container(
                  padding: const EdgeInsets.all(3),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Center(
                          child: Image.network(
                            products[index].urlImage,
                            // fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 2),
                        child: Text(
                          products[index].name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(CurrencyFormat.convertToIdr(
                          products[index].price, 0)),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
