import 'package:flutter/material.dart';

class ProfileIcon extends StatelessWidget {
  final bool isOn;

  const ProfileIcon({super.key, required this.isOn});

  @override
  Widget build(BuildContext context) {
    final String imagePath = isOn
        ? 'assets/nav/profile_nav_on.png'
        : 'assets/nav/profile_nav_off.png';

    return Image.asset(imagePath, width: 40, height: 40);
  }
}
