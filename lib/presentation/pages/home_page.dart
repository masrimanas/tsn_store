import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocBuilder, BlocListener, ReadContext;

import '../../common/values.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_product.dart';
import '../blocs/auth_bloc/auth_bloc.dart';

import '../../injection.dart' as di;
import '../widgets/common/custom_button.dart';
import '../widgets/common/custom_loading.dart';
import '../widgets/product/product_list.dart';
import 'account_page.dart';
import 'cart_page.dart';

class HomePage extends StatefulWidget {
  static const route = '/';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _data = GetProducts(di.locator()).execute();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateLoading) {
          showDialog(context: context, builder: (_) => const CustomLoading());
        } else if (state is AuthStateNone) {
          Navigator.pushNamedAndRemoveUntil(
              context, AccountPage.route, (route) => false);
        }
      },
      child: SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text(
                'Shop',
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
              backgroundColor: Colors.transparent,
              elevation: 0,
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent),
              bottom: const PreferredSize(
                // ignore: sort_child_properties_last
                child: dividerGrey,
                preferredSize: Size.fromHeight(5.0),
              ),
            ),
            body: Center(
              child: Column(
                children: [
                  Expanded(
                    child: FutureBuilder(
                        future: _data,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ProductList(
                              products: snapshot.data as List<Product>,
                            );
                          } else if (snapshot.hasError) {
                            return const Center(
                              child: Text('Terjadi Kesalahan'),
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        }),
                  ),
                  CustomButton(
                      text: 'Keluar',
                      color: Colors.blue,
                      onPressed: () {
                        context.read<AuthBloc>().add(const AuthLogoutPressed());
                      })
                ],
              ),
            )),
      ),
    );
  }
}

class LogAuthBloc extends StatelessWidget {
  const LogAuthBloc({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateNone) {
          return const Text('AuthStateNone');
        } else if (state is AuthStateLoading) {
          return const Text('AuthStateLoading');
        } else if (state is AuthStateSuccess) {
          return const Text('AuthStateSuccess');
        } else if (state is AuthStateFailure) {
          return const Text('AuthStateFailure');
        } else {
          return const Text('None');
        }
      },
    );
  }
}
