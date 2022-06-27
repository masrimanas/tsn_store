import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tsn_store/presentation/widgets/product/cart_product.dart';

import '../../common/values.dart';

class CartPage extends StatelessWidget {
  static const route = '/cart';
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Keranjang',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                ),
                color: Colors.black,
              ),
            )
          ],
          leading: const BackButton(
            color: Colors.black,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          bottom: const PreferredSize(
            // ignore: sort_child_properties_last
            child: dividerGrey,
            preferredSize: Size.fromHeight(5.0),
          ),
        ),
        body: const CartProduct());
  }
}
