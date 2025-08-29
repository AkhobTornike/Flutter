import 'package:FreeRide/widgets/main_layout.dart';
import 'package:FreeRide/widgets/sos_icon.dart';
import 'package:FreeRide/widgets/weather_widget.dart';
import 'package:flutter/material.dart';
import '../modules/map_module.dart';

class HomeScreen extends StatefulWidget {
  final bool isWeatherWidgetExpanded;

  const HomeScreen({super.key, this.isWeatherWidgetExpanded = false});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isWeatherExpanded = false;

  @override
  void initState() {
    super.initState();
    _isWeatherExpanded = widget.isWeatherWidgetExpanded;
  }

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

  void _toggleWeather() {
    setState(() {
      _isWeatherExpanded = !_isWeatherExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double collapsedHeight = 71;
    final double expandedHeight = MediaQuery.of(context).size.height * 0.535;

    return MainLayout(
      selectedPageIndex: 1,
      child: Stack(
        children: [
          // Map takes full screen
          const MapModule(),

          // Weather widget
          WeatherWidget(
            isExpanded: _isWeatherExpanded,
            onToggle: _toggleWeather,
          ),

          // SOS button only
          Positioned(
            right: 16,
            bottom: _isWeatherExpanded ? expandedHeight : collapsedHeight,
            child: IconButton(onPressed: _onSOSPressed, icon: const SosIcon()),
          ),
        ],
      ),
    );
  }
}
