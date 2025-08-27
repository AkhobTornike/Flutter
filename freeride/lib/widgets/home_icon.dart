import 'package:flutter/material.dart';

class HomeIcon extends StatelessWidget {
  final bool isOn;

  const HomeIcon({super.key, required this.isOn});

  @override
  Widget build(BuildContext context) {
    final String imagePath = isOn
        ? 'assets/nav/home_nav_on.png'
        : 'assets/nav/home_nav_off.png';

    return Image.asset(imagePath, width: 40, height: 40);
  }
}
