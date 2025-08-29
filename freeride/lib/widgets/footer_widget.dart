import 'package:FreeRide/screens/home_screen.dart';
import 'package:FreeRide/screens/login_screen.dart';
import 'package:FreeRide/screens/news_screen.dart';
import 'package:FreeRide/screens/profile_screen.dart';
import 'package:FreeRide/screens/routes_screen.dart';
import 'package:FreeRide/widgets/news_icon.dart';
import 'package:FreeRide/widgets/profile_icon.dart';
import 'package:FreeRide/widgets/routes_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:FreeRide/widgets/home_icon.dart';

class FooterWidget extends StatelessWidget {
  final int selectedPageIndex;

  const FooterWidget({super.key, required this.selectedPageIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade300, width: 1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, -1),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Use the selectedPageIndex to determine if the icon is 'on'
          IconButton(
            icon: HomeIcon(isOn: selectedPageIndex == 1),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          ),
          IconButton(
            icon: RoutesIcon(isOn: selectedPageIndex == 2),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const RouteScreen()),
              );
            },
          ),
          IconButton(
            icon: NewsIcon(isOn: selectedPageIndex == 3),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const NewsScreen()),
              );
            },
          ),
          IconButton(
            icon: ProfileIcon(isOn: selectedPageIndex == 4),
            onPressed: () {
              final user = FirebaseAuth.instance.currentUser;
              if (user == null) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
