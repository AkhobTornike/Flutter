import 'package:flutter/material.dart';

class LogoTextWidget extends StatelessWidget {
  final double width;
  final double height;

  const LogoTextWidget({super.key, this.width = 1500, this.height = 100});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo_text.png',
      width: width,
      height: height,
      fit: BoxFit.contain,
    );
  }
}
