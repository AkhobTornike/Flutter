import 'package:flutter/material.dart';
import 'package:FreeRide/models/onboarding_model.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingItem item;

  const OnboardingPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive design
    final screenSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        // Aligns all children to the top
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Image takes a portion of screen height
          SizedBox(
            width: screenSize.width,
            height: screenSize.height * 0.4,
            child: Image.asset(
              item.image,
              fit: BoxFit.cover, // Ensures the image covers the box
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(Icons.error, size: 100, color: Colors.grey[600]),
                );
              },
            ),
          ),

          // Container for text content
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Column(
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  item.description,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          // Add a SizedBox for a margin at the bottom
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
