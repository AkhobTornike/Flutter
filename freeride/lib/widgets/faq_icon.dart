import 'package:flutter/material.dart';

class FaqIcon extends StatelessWidget {
  final bool isOn;

  const FaqIcon({super.key, required this.isOn});

  @override
  Widget build(BuildContext context) {
    final String imagePath = isOn
        ? 'assets/nav/faq_nav_on.png'
        : 'assets/nav/faq_nav_off.png';

    return Image.asset(imagePath, width: 40, height: 40);
  }
}
