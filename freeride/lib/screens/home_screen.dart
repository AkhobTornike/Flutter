import 'package:FreeRide/widgets/main_layout.dart';
import 'package:FreeRide/widgets/sos_icon.dart';
import 'package:flutter/material.dart';
import '../modules/map_module.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _onSOSPressed() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('SOS'),
        content: const Text('გსურთ გაუგზავნოთ SOS? (This is a demo action)'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Send'),
          ),
        ],
      ),
    );

    if (result == true) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('SOS sent (demo)')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      selectedPageIndex: 1,
      child: Stack(
        children: [
          // Map takes full screen
          const MapModule(),

          // SOS button only
          Positioned(
            right: 16,
            bottom: 16,
            child: IconButton(onPressed: _onSOSPressed, icon: const SosIcon()),
          ),
        ],
      ),
    );
  }
}
