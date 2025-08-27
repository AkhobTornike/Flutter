import 'package:flutter/material.dart';

class NewsIcon extends StatelessWidget {
  final bool isOn;

  const NewsIcon({super.key, required this.isOn});

  @override
  Widget build(BuildContext context) {
    final String imagePath = isOn
        ? 'assets/nav/news_nav_on.png'
        : 'assets/nav/news_nav_off.png';

    return Image.asset(imagePath, width: 60, height: 60);
  }
}
