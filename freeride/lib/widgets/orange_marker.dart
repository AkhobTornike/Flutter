// widgets/orange_marker_widget.dart
import 'package:flutter/material.dart';

class OrangeMarkerWidget extends StatelessWidget {
  final double size;
  final VoidCallback onTap;

  const OrangeMarkerWidget({super.key, this.size = 40, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Handle tap to remove the marker
      child: Image.asset(
        'assets/images/marker_orange.png', // Your custom orange marker
        width: size,
        height: size,
        errorBuilder: (context, error, stackTrace) {
          return Icon(Icons.location_on, color: Colors.orange, size: size);
        },
      ),
    );
  }
}
