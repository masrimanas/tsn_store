import 'package:flutter/material.dart';
import 'package:tsn_store/domain/entities/user.dart';
import 'package:tsn_store/domain/usecases/sign_up_user.dart';
import 'package:tsn_store/presentation/widgets/common/custom_dialog.dart';

import '../common/custom_button.dart';
import '../common/user_input.dart';

import '../../../injection.dart' as di;

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  RegisterViewState createState() {
    return RegisterViewState();
  }
}

class RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
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
                inputController: _nameController,
                icon: const Icon(
                  Icons.email_outlined,
                  color: Colors.grey,
                ),
                text: 'Nama Lengkap',
                type: TextInputType.name,
                isPassword: false,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: UserInput(
                  inputController: _emailController,
                  icon: const Icon(
                    Icons.email_outlined,
                    color: Colors.grey,
                  ),
                  text: 'Email',
                  type: TextInputType.emailAddress,
                  isPassword: false,
                ),
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
                child: Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: UserInput(
                        isEnabled: false,
                        text: '',
                        type: TextInputType.phone,
                        isPassword: false,
                        initialValue: '+62',
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 4,
                      child: UserInput(
                        inputController: _phoneController,
                        text: 'Nomor HP',
                        type: TextInputType.phone,
                        isPassword: false,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: CustomButton(
                  text: 'Buat Akun',
                  color: Colors.blue,
                  onPressed: () {
                    final userToSingUp = User(
                        id: 'id',
                        email: _emailController.text,
                        password: _passwordController.text);
                    if (_formKey.currentState!.validate()) {
                      SignUpUser(di.locator()).execute(userToSingUp);
                      showDialog(
                        context: context,
                        builder: (_) => CustomDialog(
                            button: CustomButton(
                                color: Colors.blue,
                                text: 'OK',
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                            desc: 'Ayo mulai berbelanja!',
                            title: 'Pendaftaran berhasil.',
                            url:
                                'https://cdn.iconscout.com/icon/free/png-256/shopping-trolley-2130858-1794989.png'),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
