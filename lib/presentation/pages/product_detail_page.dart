import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tsn_store/common/values.dart';
import 'package:tsn_store/domain/entities/product.dart';
import 'package:tsn_store/domain/usecases/add_to_cart.dart';
import 'package:tsn_store/presentation/widgets/common/custom_button.dart';
import 'package:tsn_store/presentation/widgets/common/custom_dialog.dart';

import '../../common/enums.dart';
import '../../utils/formatter.dart';
import '../blocs/auth_bloc/auth_bloc.dart';

import '../../injection.dart' as di;
import 'cart_page.dart';

class ProductDetailPage extends StatefulWidget {
  static const route = '/detail';
  final Product product;

  const ProductDetailPage({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int? _choice = 0;

  Gender _selectedGender = Gender.P;
  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthBloc>().state.user;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Detail Produk',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, CartPage.route);
                },
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
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          bottom: const PreferredSize(
            // ignore: sort_child_properties_last
            child: dividerBlack,
            preferredSize: Size.fromHeight(5.0),
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Center(
                      child: Image.network(
                        widget.product.urlImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 10, 0, 3),
                    child: Text(
                      widget.product.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                    child: Text(
                        CurrencyFormat.convertToIdr(widget.product.price, 0)),
                  ),
                ],
              ),
            ),
            dividerBlack,
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Flexible(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'Pilih jenis kelamin',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                  Flexible(
                    child: ListTile(
                      title: const Text('Pria'),
                      leading: Radio<Gender>(
                        value: Gender.P,
                        groupValue: _selectedGender,
                        onChanged: (Gender? value) {
                          setState(() {
                            _selectedGender = value!;
                            log(_selectedGender.text);
                          });
                        },
                      ),
                    ),
                  ),
                  Flexible(
                    child: ListTile(
                      title: const Text('Wanita'),
                      leading: Radio<Gender>(
                        value: Gender.W,
                        groupValue: _selectedGender,
                        onChanged: (Gender? value) {
                          setState(() {
                            _selectedGender = value!;
                            log(_selectedGender.text);
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            dividerBlack,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Pilih ukuran',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      spacing: 10,
                      children: List<Widget>.generate(
                        widget.product.size.length,
                        (int index) {
                          return ChoiceChip(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            label: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(widget.product.size[index]),
                            ),
                            selected: _choice == index,
                            onSelected: (bool selected) {
                              setState(() {
                                _choice = selected ? index : null;
                                log(_choice.toString());
                              });
                            },
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(child: SizedBox(height: 8)),
            CustomButton(
              text: '+Keranjang',
              color: Colors.blue,
              onPressed: () {
                final productToAdd = Product(
                  id: widget.product.id,
                  gender: [_selectedGender.text],
                  name: widget.product.name,
                  price: widget.product.price,
                  urlImage: widget.product.urlImage,
                  size: [widget.product.size[_choice!]],
                );
                AddToCart(di.locator()).execute(productToAdd, user);

                showDialog(
                    context: context,
                    builder: (_) => CustomDialog(
                          url:
                              "https://cdn.iconscout.com/icon/free/png-256/shopping-trolley-2130858-1794989.png",
                          title: "Produk berhasil ditambahkan",
                          desc: "Cek keranjangmu untuk lihat produk",
                          button: CustomButton(
                            text: 'Lihat Keranjang',
                            color: Colors.blue,
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(context, CartPage.route);
                            },
                          ),
                        ));
                log(productToAdd.name);
                log(user.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
