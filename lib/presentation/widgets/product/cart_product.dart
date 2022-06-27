import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/load_product.dart';
import '../../../injection.dart' as di;
import '../../../utils/formatter.dart';
import '../../blocs/auth_bloc/auth_bloc.dart';

class CartProduct extends StatefulWidget {
  const CartProduct({Key? key}) : super(key: key);

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthBloc>().state.user;
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: LoadProduct(di.locator()).execute(user),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.docs.isEmpty || snapshot.data == null) {
            return Container(
              color: Colors.grey[200],
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  'Keranjang Kosong',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                )),
              ),
            );
          }
          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                final data = snapshot.data?.docs[index].data();
                // final products = data.map();
                // final product = ProductModel.fromMap(data);
                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200]),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 75,
                        height: 75,
                        child: Image.network(
                          data!['url_image'],
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 75,
                        height: 75,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data['name'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Size: ${data['size']}',
                            ),
                            Text(CurrencyFormat.convertToIdr(data['price'], 0)),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });
        });
  }
}
