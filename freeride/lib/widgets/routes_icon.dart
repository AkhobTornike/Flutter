import 'package:flutter/material.dart';

class RoutesIcon extends StatelessWidget {
  final bool isOn;

  const RoutesIcon({super.key, required this.isOn});

  @override
  Widget build(BuildContext context) {
    final String imagePath = isOn
        ? 'assets/nav/routes_nav_on.png'
        : 'assets/nav/routes_nav_off.png';

    return Image.asset(imagePath, width: 60, height: 60);
  }
}
