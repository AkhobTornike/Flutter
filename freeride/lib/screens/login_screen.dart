import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:FreeRide/pages/login_form.dart';
import 'package:FreeRide/widgets/social_login_buttons.dart';
import 'package:FreeRide/screens/register_screen.dart';
import 'package:FreeRide/widgets/logo_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LogoWidget(size: 120),
            const SizedBox(height: 50),

            // Login Form
            const LoginForm(),
            const SizedBox(height: 30),

            // Divider with "or"
            Row(
              children: [
                const Expanded(child: Divider(color: Colors.grey)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text('ან', style: TextStyle(color: Colors.grey[600])),
                ),
                const Expanded(child: Divider(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 30),

            // Social login buttons
            const SocialLoginButtons(),
            const SizedBox(height: 30),

            // Create Account
            Text(
              'არ გაქვთ ანგარიში?',
              style: TextStyle(color: Colors.grey[600]),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterScreen(),
                  ),
                );
              },
              child: const Text(
                'რეგისტრაცია',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Terms
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'გაგრძელებისას, თქვენ ეთანხმებით ჩვენს ',
                    ),
                    TextSpan(
                      text: 'წესებსა',
                      style: const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                    const TextSpan(text: ' და '),
                    TextSpan(
                      text: 'კონფიდენციალურობის',
                      style: const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                    const TextSpan(text: ' პოლიტიკას'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
