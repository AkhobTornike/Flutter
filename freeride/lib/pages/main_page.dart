import 'package:FreeRide/screens/home_screen.dart';
import 'package:FreeRide/screens/news_screen.dart';
import 'package:FreeRide/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const NewsScreen(),
    const ProfilePage(), // placeholder
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
    );
  }
}
