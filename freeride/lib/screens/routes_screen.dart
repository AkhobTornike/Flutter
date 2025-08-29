import 'package:FreeRide/screens/home_screen.dart';
import 'package:FreeRide/screens/news_screen.dart';
import 'package:FreeRide/widgets/icon_bg_icon.dart';
import 'package:FreeRide/widgets/main_layout.dart';
import 'package:flutter/material.dart';

class RouteScreen extends StatefulWidget {
  const RouteScreen({super.key});

  @override
  State<RouteScreen> createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  final List<Map<String, dynamic>> routesList = [
    {
      "image": "assets/images/route_image.png",
      "title": "ულამაზესი სამთო უღელტეხილი",
      "difficulty": "საშუალო",
      "length": "12.4 კმ",
      "rating": 4.8,
      "temperature": "25°C",
      "weatherIcon": Icons.wb_sunny,
      "details":
          "ულამაზესი სამთო მარშრუტი პანორამული ხედებით. იდეალურია საშუალო დონის მოთხილამურეებისთვის.",
    },
    {
      "image": "assets/images/route_image.png",
      "title": "ტყის სათავგადასავლო ბილიკი",
      "difficulty": "მარტივი",
      "length": "8.7 კმ",
      "rating": 4.5,
      "temperature": "18°C",
      "weatherIcon": Icons.cloud,
      "details":
          "დასასვენებელი გასეირნება ხშირ ტყეში კარგად მოვლილი ბილიკებით.",
    },
    {
      "image": "assets/images/route_image.png",
      "title": "სანაპირო მაგისტრალი",
      "difficulty": "რთული",
      "length": "22.1 კმ",
      "rating": 4.9,
      "temperature": "22°C",
      "weatherIcon": Icons.wb_cloudy,
      "details":
          "რთული სანაპირო მარშრუტი ციცაბო აღმართებითა და ოკეანის ხედებით.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      selectedPageIndex: 2,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const IconBg(),
            const SizedBox(height: 4),
            Text(
              "მარშრუტები",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const NewsScreen()),
              );
            },
          ),
        ],
        toolbarHeight: 100,
      ),
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: routesList.length,
        itemBuilder: (context, index) {
          final route = routesList[index];

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Route Image
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      Image.asset(
                        route["image"],
                        height: 200,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      // Weather indicator on top of image
                      Positioned(
                        top: 12,
                        right: 12,
                        // Wrap the container in a button widget
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(
                                  isWeatherWidgetExpanded: true,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.6),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  route["weatherIcon"],
                                  color: Colors.white,
                                  size: 18,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  route["temperature"],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Route Information
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and Rating
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              route["title"],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                route["rating"].toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Difficulty and Length
                      Row(
                        children: [
                          _buildInfoChip(
                            icon: Icons.terrain,
                            text: route["difficulty"],
                            color: _getDifficultyColor(route["difficulty"]),
                          ),
                          const SizedBox(width: 8),
                          _buildInfoChip(
                            icon: Icons.alt_route,
                            text: route["length"],
                            color: Colors.blue.shade100,
                          ),
                          const Spacer(),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Description
                      Text(
                        route["details"],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                        ),
                      ),

                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14),
          const SizedBox(width: 4),
          Text(text, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'მარტივი':
        return Colors.green.shade100;
      case 'საშუალო':
        return Colors.orange.shade100;
      case 'რთული':
        return Colors.red.shade100;
      default:
        return Colors.grey.shade100;
    }
  }
}
