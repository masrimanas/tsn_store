import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsn_store/domain/entities/product.dart';
import 'package:tsn_store/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:tsn_store/presentation/pages/account_page.dart';
import 'package:tsn_store/presentation/pages/cart_page.dart';

import 'common/firebase_options.dart';
import 'presentation/pages/home_page.dart';

import './injection.dart' as di;
import 'presentation/pages/product_detail_page.dart';

void main() async {
  di.init();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            di.locator(),
            di.locator(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'TSN Store',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AuthGate(),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomePage.route:
              return MaterialPageRoute(builder: (_) => const HomePage());
            case AccountPage.route:
              return MaterialPageRoute(builder: (_) => const AccountPage());
            case CartPage.route:
              return MaterialPageRoute(builder: (_) => const CartPage());
            case ProductDetailPage.route:
              final product = settings.arguments as Product;
              return MaterialPageRoute(
                  builder: (_) => ProductDetailPage(
                        product: product,
                      ));
            default:
              return MaterialPageRoute(
                builder: (_) => const Scaffold(
                  body: Center(
                    child: Text('Terjadi kesalahan!'),
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateNone) {
          return const AccountPage();
        } else {
          return const HomePage();
        }
      },
    );
  }
}
