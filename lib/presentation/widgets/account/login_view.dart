import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext;
import 'package:tsn_store/presentation/blocs/auth_bloc/auth_bloc.dart';

import '../../../domain/entities/user.dart';
import '../common/custom_button.dart';
import '../common/user_input.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  LoginViewState createState() {
    return LoginViewState();
  }
}

class LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 50, 16, 50),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UserInput(
                inputController: _emailController,
                isEmail: true,
                icon: const Icon(
                  Icons.email_outlined,
                  color: Colors.grey,
                ),
                text: 'Email',
                type: TextInputType.emailAddress,
                isPassword: false,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: UserInput(
                  inputController: _passwordController,
                  icon: const Icon(
                    Icons.lock_outline,
                    color: Colors.grey,
                  ),
                  text: 'Password',
                  type: TextInputType.emailAddress,
                  isPassword: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: CustomButton(
                  text: 'Masuk',
                  color: Colors.blue,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final userDetail = User(
                          id: '',
                          email: _emailController.text,
                          password: _passwordController.text);

                      context
                          .read<AuthBloc>()
                          .add(AuthLoginPressed(user: userDetail));
                      Navigator.pop(context);
                      log('Login Pressed');
                    }
                  },
                ),
              ),
              TextButton(onPressed: () {}, child: const Text('Buat Akun'))
            ],
          ),
        ),
      ),
    );
  }
}
