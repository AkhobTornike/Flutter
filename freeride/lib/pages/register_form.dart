import 'package:flutter/material.dart';
import '../models/register_model.dart';
import '../models/register_validations.dart';
import '../widgets/validation_row.dart';
import '../widgets/success_dialog.dart';
import '../services/auth_service.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  // Controllers & Focus
  final _model = RegisterModel();
  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _repeatPasswordFocus = FocusNode();

  bool _isPasswordVisible = false;
  bool _isFormValid = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _model.addListeners(_validateForm);
  }

  @override
  void dispose() {
    _model.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _repeatPasswordFocus.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _isFormValid = RegisterValidations.isFormValid(_model);
    });
  }

  Future<void> _handleRegister() async {
    setState(() => _isLoading = true);
    try {
      await AuthService.instance.registerWithEmail(
        _model.emailController.text,
        _model.passwordController.text,
      );
      if (!mounted) return;
      showSuccessDialog(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst('Exception: ', ''))),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Image.asset('assets/images/logo.png', width: 120, height: 120),
          const SizedBox(height: 20),
          Text("რეგისტრაცია", style: Theme.of(context).textTheme.titleLarge),

          const SizedBox(height: 30),

          // ✅ Example: Name field
          TextField(
            controller: _model.nameController,
            focusNode: _nameFocus,
            decoration: const InputDecoration(labelText: "სრული სახელი"),
          ),
          if (!_model.isNameValid)
            const ValidationRow("შეიყვანეთ სრული სახელი", false),

          const SizedBox(height: 20),

          // ✅ Email field
          TextField(
            controller: _model.emailController,
            focusNode: _emailFocus,
            decoration: const InputDecoration(labelText: "ელ.ფოსტა"),
          ),
          if (!_model.isEmailValid)
            const ValidationRow("არ არის ვალიდური", false),

          const SizedBox(height: 20),

          // ✅ Password
          TextField(
            controller: _model.passwordController,
            focusNode: _passwordFocus,
            obscureText: !_isPasswordVisible,
            decoration: InputDecoration(
              labelText: "პაროლი",
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () =>
                    setState(() => _isPasswordVisible = !_isPasswordVisible),
              ),
            ),
          ),

          // Password rules
          ValidationRow("მინიმუმ 8 სიმბოლო", _model.hasMinLength),
          ValidationRow("მინიმუმ 1 ციფრი", _model.hasNumber),
          ValidationRow("მინიმუმ 1 დიდი ასო", _model.hasUppercase),

          const SizedBox(height: 20),

          // ✅ Repeat Password
          TextField(
            controller: _model.repeatPasswordController,
            focusNode: _repeatPasswordFocus,
            obscureText: !_isPasswordVisible,
            decoration: const InputDecoration(labelText: "გაიმეორეთ პაროლი"),
          ),
          if (!_model.passwordsMatch)
            const ValidationRow("პაროლები უნდა ემთხვეოდეს", false),

          const SizedBox(height: 30),

          // ✅ Register button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _isFormValid && !_isLoading ? _handleRegister : null,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text("რეგისტრაცია"),
            ),
          ),
        ],
      ),
    );
  }
}
