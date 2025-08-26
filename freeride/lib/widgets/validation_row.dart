import 'package:flutter/material.dart';

class ValidationRow extends StatelessWidget {
  final String text;
  final bool isValid;

  const ValidationRow(this.text, this.isValid, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.cancel,
          size: 16,
          color: isValid ? Colors.green : Colors.red,
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(color: isValid ? Colors.green : Colors.red),
        ),
      ],
    );
  }
}
