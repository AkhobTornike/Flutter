import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  int _currentSplash = 0;
  late AnimationController _arcController;

  @override
  void initState() {
    super.initState();

    // Arc rotation animation
    _arcController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _startSplashSequence();
  }

  void _startSplashSequence() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _currentSplash = 1);

    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() => _currentSplash = 2);

    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;
    setState(() => _currentSplash = 3);

    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  @override
  void dispose() {
    _arcController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: _buildSplashStage(_currentSplash),
      ),
    );
  }

  Widget _buildSplashStage(int stage) {
    switch (stage) {
      case 0: // Stage 1: gradient + logo + rotating arc
        return Container(
          key: const ValueKey(0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF00C6FF), Color(0xFF0072FF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset("assets/logo_icon.png", width: 120),
                SizedBox(
                  width: 150,
                  height: 150,
                  child: AnimatedBuilder(
                    animation: _arcController,
                    builder: (_, __) {
                      return Transform.rotate(
                        angle: _arcController.value * 2 * pi,
                        child: CustomPaint(painter: ArcPainter()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );

      case 1: // Stage 2: just logo
        return Center(
          key: const ValueKey(1),
          child: Image.asset("assets/logo_icon.png", width: 120),
        );

      case 2: // Stage 3: bigger logo
        return Center(
          key: const ValueKey(2),
          child: Image.asset("assets/logo_icon.png", width: 250),
        );

      case 3: // Stage 4: full logo
        return Center(
          key: const ValueKey(3),
          child: Image.asset("assets/logo_full.png", width: 400),
        );

      default:
        return const SizedBox.shrink();
    }
  }
}

/// Painter for circular arc (loading line)
class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00C6FF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    // Draw arc (about 1/3 of circle)
    canvas.drawArc(rect, 0, pi * 1.3, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
