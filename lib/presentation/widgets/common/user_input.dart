import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class UserInput extends StatelessWidget {
  final Icon? icon;
  final TextEditingController? inputController;
  final bool isEnabled;
  final bool isEmail;
  final bool isPassword;
  final String? initialValue;
  final String text;
  final TextInputType type;

  const UserInput({
    Key? key,
    this.icon,
    this.inputController,
    this.isEnabled = true,
    this.isEmail = false,
    required this.isPassword,
    this.initialValue,
    required this.text,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(12, 26),
            blurRadius: 50,
            spreadRadius: 0,
            color: Colors.grey.withOpacity(.1)),
      ]),
      child: TextFormField(
        initialValue: initialValue,
        validator: (value) {
          if (value!.isEmpty) {
            return '$text harus diisi';
          }
          if (value.length < 8 && isPassword) {
            return '$text harus 8 karakter atau lebih';
          }
          if (isEmail && !EmailValidator.validate(value)) {
            return 'Masukkan $text yang benar';
          }
          return null;
        },
        controller: inputController,
        keyboardType: type,
        obscureText: isPassword,
        enabled: isEnabled,
        style: const TextStyle(fontSize: 14, color: Colors.black),
        decoration: InputDecoration(
          prefixIcon: icon,
          filled: true,
          hintText: text,
          hintStyle: TextStyle(
              color: isEnabled ? Colors.grey.withOpacity(.75) : Colors.black),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
      ),
    );
  }
}
