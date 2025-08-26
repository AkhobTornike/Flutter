import 'package:flutter/material.dart';
import 'register_validations.dart';

class RegisterModel {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();

  bool get isNameValid => nameController.text.trim().isNotEmpty;
  bool get isEmailValid =>
      RegisterValidations.validateEmail(emailController.text);
  bool get hasMinLength => passwordController.text.length >= 8;
  bool get hasNumber => RegExp(r'\d').hasMatch(passwordController.text);
  bool get hasUppercase => RegExp(r'[A-Z]').hasMatch(passwordController.text);
  bool get passwordsMatch =>
      passwordController.text == repeatPasswordController.text;

  void addListeners(VoidCallback listener) {
    nameController.addListener(listener);
    emailController.addListener(listener);
    passwordController.addListener(listener);
    repeatPasswordController.addListener(listener);
  }

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
  }
}
