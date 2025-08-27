import 'package:FreeRide/screens/login_screen.dart';
import 'package:flutter/material.dart';

void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 60),
          const SizedBox(height: 16),
          const Text(
            "დარეგისტრირდით წარმატებით!",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            ),
            child: const Text("შესვლა"),
          ),
        ],
      ),
    ),
  );
}
