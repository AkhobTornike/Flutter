// widgets/blue_marker_widget.dart
import 'package:flutter/material.dart';

class BlueMarkerWidget extends StatelessWidget {
  final double size;

  const BlueMarkerWidget({super.key, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/marker_blue.png',
      width: size,
      height: size,
      errorBuilder: (context, error, stackTrace) {
        return Icon(Icons.location_on, color: Colors.blue, size: size);
      },
    );
  }
}
