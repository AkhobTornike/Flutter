import 'package:FreeRide/widgets/compas_icon.dart';
import 'package:FreeRide/widgets/distance_icon.dart';
import 'package:FreeRide/widgets/gps_icon.dart';
import 'package:FreeRide/widgets/mountain_icon.dart';
import 'package:FreeRide/widgets/snow_flake_icon.dart';
import 'package:FreeRide/widgets/time_icon.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromRGBO(55, 117, 192, 1),
                Color.fromRGBO(5, 185, 219, 1),
              ],
            ),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Left Panel
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const MountainIcon(),
                          const SizedBox(width: 5),
                          const Text(
                            'ბახმარო კურორტი',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Row(
                        children: [
                          const DistanceIcon(),
                          const SizedBox(width: 5),
                          const Text(
                            '1,832მ',
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                          const SizedBox(width: 10),
                          const TimeIcon(),
                          const SizedBox(width: 5),
                          const Text(
                            '21:04',
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                          const SizedBox(width: 10),
                          const GpsIcon(),
                          const SizedBox(width: 5),
                          const Text(
                            'N/S',
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                          const SizedBox(width: 2),
                          const CompasIcon(),
                        ],
                      ),
                    ],
                  ),
                  // Right Panel
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SnowFlakeIcon(),
                      const SizedBox(height: 5),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            156,
                            110,
                            234,
                            253,
                          ),
                          shadowColor: Colors.black.withValues(alpha: 0.9),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          '-7° C',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 54, 225, 59),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 10, 248, 18)
                            .withValues(
                              alpha: 0.8,
                            ), // Correct method for transparency
                        blurRadius: 5,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
