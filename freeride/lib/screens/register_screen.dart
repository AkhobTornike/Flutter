import 'package:flutter/material.dart';
import '../pages/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: RegisterForm(), // ✅ move form logic outside
      ),
    );
  }
}
