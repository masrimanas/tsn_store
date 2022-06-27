import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocListener;
import 'package:tsn_store/presentation/pages/home_page.dart';
import 'package:tsn_store/presentation/widgets/common/custom_dialog.dart';
import 'package:tsn_store/presentation/widgets/common/custom_loading.dart';

import '../blocs/auth_bloc/auth_bloc.dart';
import '../widgets/account/login_view.dart';
import '../widgets/account/register_view.dart';
import '../widgets/common/custom_button.dart';

class AccountPage extends StatefulWidget {
  static const route = 'account';

  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String title = '';
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateLoading) {
          showDialog(context: context, builder: (_) => const CustomLoading());
        } else if (state is AuthStateSuccess) {
          Navigator.pushNamedAndRemoveUntil(
              context, HomePage.route, (route) => false);
        } else if (state is AuthStateFailure) {
          showDialog(
            context: context,
            builder: (_) => CustomDialog(
                button: CustomButton(
                    text: 'Coba Lagi',
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.pop;
                    }),
                desc: 'Gagal Login',
                title: 'Gagal Login',
                url: ''),
          );
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            title,
            style: const TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(70),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/tsn-store.png',
                  ),
                ),
                CustomButton(
                  text: 'Masuk',
                  color: Colors.blue,
                  onPressed: () {
                    setState(() {
                      title = 'Form Login';
                    });
                    showModalBottomSheet<void>(
                        isDismissible: true,
                        enableDrag: false,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        context: context,
                        builder: (BuildContext context) {
                          return const SingleChildScrollView(
                            child: SingleChildScrollView(child: LoginView()),
                          );
                        });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  text: 'Buat Akun',
                  color: Colors.blue,
                  onPressed: () {
                    setState(() {
                      title = 'Form Register';
                    });
                    showModalBottomSheet<void>(
                        isDismissible: true,
                        enableDrag: false,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        context: context,
                        builder: (BuildContext context) {
                          return const SingleChildScrollView(
                              child: RegisterView());
                        });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
