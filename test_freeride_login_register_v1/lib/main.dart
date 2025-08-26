import 'package:flutter/material.dart';
import 'package:FreeRide/splash_screen.dart';

void main() {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Precache images to prevent loading delays
  _precacheAssets();

  runApp(const MyApp());
}

Future<void> _precacheAssets() async {
  // This will help prevent any loading delays for images
  // Actual precaching happens in the splash screen
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Added a theme to avoid using deprecated features
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
