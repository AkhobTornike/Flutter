import 'package:flutter/material.dart';

class InfoBoxWidget extends StatelessWidget {
  const InfoBoxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 40,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromRGBO(17, 84, 171, 1),
                Color.fromRGBO(5, 185, 219, 100),
              ],
            ),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left Panerl
              Column(
                children: [
                  // top panel
                  Row(
                    children: [
                      const Icon(Icons.landscape),
                      const SizedBox(width: 5),
                      Text(
                        'ბახმარო კურორტი',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  // bottom panel
                  Row(
                    children: [
                      // 3 containers
                      const Icon(Icons.location_pin),
                      const SizedBox(width: 5),
                      const Text(
                        '1,832მ',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),

                      const SizedBox(width: 15),

                      const Icon(Icons.access_time),
                      const SizedBox(width: 5),
                      const Text(
                        '21:04',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),

                      const SizedBox(width: 15),

                      const Icon(Icons.gps_fixed),
                      const SizedBox(width: 5),
                      const Text(
                        'N/S',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),

              // Right Panel
              Column(
                children: [
                  const Icon(Icons.snowing, size: 40),
                  const SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(1),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                    ),
                    child: const Text('-7° C'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
