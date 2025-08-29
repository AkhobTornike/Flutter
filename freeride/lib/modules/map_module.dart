// modules/map_module.dart
import 'package:FreeRide/widgets/blue_marker.dart';
import 'package:FreeRide/widgets/orange_marker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapModule extends StatefulWidget {
  const MapModule({super.key});

  @override
  State<MapModule> createState() => _MapModuleState();
}

class _MapModuleState extends State<MapModule> {
  LatLng? _currentLocation;
  LatLng? _selectedLocation; // Stores the orange marker position
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() => _isLoading = false);
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  void _onMapTap(TapPosition tapPosition, LatLng latLng) {
    setState(() {
      _selectedLocation = latLng; // Set orange marker position on map tap
    });
  }

  void _removeOrangeMarker() {
    setState(() {
      _selectedLocation = null; // Remove orange marker when tapped
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_currentLocation == null) {
      return const Center(child: Text('Location not available'));
    }

    return FlutterMap(
      options: MapOptions(
        initialCenter: _currentLocation!,
        initialZoom: 15,
        onTap: _onMapTap, // Handle map taps to add orange marker
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.freeride',
        ),

        // Blue marker - YOUR current location (custom widget)
        MarkerLayer(
          markers: [
            Marker(
              point: _currentLocation!,
              width: 50,
              height: 50,
              child: const BlueMarkerWidget(size: 50),
            ),
          ],
        ),

        // Orange marker - Only appears when you tap the map, disappears when tapped
        if (_selectedLocation != null)
          MarkerLayer(
            markers: [
              Marker(
                point: _selectedLocation!,
                width: 50,
                height: 50,
                child: OrangeMarkerWidget(
                  size: 50,
                  onTap: _removeOrangeMarker, // Tap to remove this marker
                ),
              ),
            ],
          ),
      ],
    );
  }
}
