import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isPasswordVisible = false;
  String _password = "";

  bool get hasMinLength => _password.length >= 8;
  bool get hasNumber => _password.contains(RegExp(r'[0-9]'));
  bool get hasUppercase => _password.contains(RegExp(r'[A-Z]'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),

            // Back Button
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            const SizedBox(height: 20),

            // Logo
            Image.asset('assets/logo.png', height: 100),

            const SizedBox(height: 10),
            const Text(
              "რეგისტრაცია",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            // Name Field
            TextField(
              decoration: InputDecoration(
                labelText: 'სახელი',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Email Field
            TextField(
              decoration: InputDecoration(
                labelText: 'ელ.ფოსტა',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Password Field
            TextField(
              obscureText: !_isPasswordVisible,
              onChanged: (value) {
                setState(() {
                  _password = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'პაროლი',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Password Rules
            Row(
              children: [
                Icon(
                  hasMinLength ? Icons.check_circle : Icons.cancel,
                  color: hasMinLength ? Colors.green : Colors.red,
                  size: 18,
                ),
                const SizedBox(width: 5),
                Text(
                  'მინიმუმ 8 სიმბოლო',
                  style: TextStyle(
                    color: hasMinLength ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  hasNumber ? Icons.check_circle : Icons.cancel,
                  color: hasNumber ? Colors.green : Colors.red,
                  size: 18,
                ),
                const SizedBox(width: 5),
                Text(
                  'მინიმუმ ერთი ციფრი',
                  style: TextStyle(
                    color: hasNumber ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  hasUppercase ? Icons.check_circle : Icons.cancel,
                  color: hasUppercase ? Colors.green : Colors.red,
                  size: 18,
                ),
                const SizedBox(width: 5),
                Text(
                  'მინიმუმ ერთი დიდი ასო',
                  style: TextStyle(
                    color: hasUppercase ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Register Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: (hasMinLength && hasNumber && hasUppercase)
                      ? Colors.blue
                      : Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: (hasMinLength && hasNumber && hasUppercase)
                    ? () {}
                    : null,
                child: const Text(
                  'რეგისტრაცია',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Google Button
            _socialButton(
              icon: Icons.g_mobiledata_outlined,
              text: "შესვლა Google-ით",
              onTap: () {},
            ),
            const SizedBox(height: 20),

            // Facebook Button
            _socialButton(
              icon: Icons.facebook,
              text: "შესვლა Facebook-ით",
              onTap: () {},
            ),
            const SizedBox(height: 20),

            // Apple Button
            _socialButton(
              icon: Icons.apple,
              text: "შესვლა Apple-ით",
              onTap: () {},
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// Social Button Widget
Widget _socialButton({
  required IconData icon,
  required String text,
  required VoidCallback onTap,
}) {
  return SizedBox(
    width: double.infinity,
    height: 50,
    child: OutlinedButton.icon(
      icon: Icon(icon, size: 30),
      label: Text(text, style: const TextStyle(fontSize: 16)),
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );
}
