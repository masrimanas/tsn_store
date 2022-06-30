import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsn_store/domain/entities/product.dart';
import 'package:tsn_store/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:tsn_store/presentation/pages/account_page.dart';
import 'package:tsn_store/presentation/pages/cart_page.dart';
import 'package:tsn_store/presentation/widgets/common/custom_loading.dart';

import 'common/firebase_options.dart';
import 'presentation/pages/home_page.dart';

import './injection.dart' as di;
import 'presentation/pages/product_detail_page.dart';
import 'presentation/widgets/common/custom_button.dart';
import 'presentation/widgets/common/custom_dialog.dart';

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
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateNone) {
          Navigator.pop(context);
        }
        if (state is AuthStateLoading) {
          showDialog(
            context: context,
            builder: (_) => const CustomLoading(),
          );
        }
        if (state is AuthStateSuccess) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (state is AuthStateNone) {
          return StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const HomePage();
                }
                return const AccountPage();
              });
        }

        if (state is AuthStateSuccess) {
          return const HomePage();
        }
        if (state is AuthStateFailure) {
          final dialog = CustomDialog(
              button: CustomButton(
                  text: 'Coba Lagi',
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.pop;
                  }),
              title: 'Terjadi kesalahan',
              desc: state.message,
              url: '');

          return dialog;
        } else {
          return Builder(builder: (context) {
            return Scaffold(
              body: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Terjadi kesalahan!'),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AccountPage.route);
                      },
                      child: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            );
          });
        }
      },
    );
  }
}
