import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:FreeRide/screens/onboarding_screen.dart';
import 'package:FreeRide/widgets/logo_widget.dart';
import 'package:FreeRide/widgets/logo_text_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<Color?> _backgroundColorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    );

    _backgroundColorAnimation =
        ColorTween(begin: Colors.blue, end: Colors.white).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.4, 0.7, curve: Curves.easeInOut),
          ),
        );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.7, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.forward().then((_) {
      if (mounted) {
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const OnboardingScreen()),
            );
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final whiteCircleSize = screenWidth * 0.3;
    final logoSize = whiteCircleSize * 0.8;
    final textWidth = screenWidth * 1.5;
    final textHeight = textWidth * 0.75;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: _backgroundColorAnimation.value,
          body: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // ---------- PHASE 1 ----------
                if (_controller.value <= 0.5) ...[
                  // White circle background
                  Container(
                    width: whiteCircleSize,
                    height: whiteCircleSize,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  // Rotating arc inside
                  SizedBox(
                    width: whiteCircleSize,
                    height: whiteCircleSize,
                    child: Transform.rotate(
                      angle: _controller.value * 2 * math.pi * 2,
                      child: CustomPaint(painter: ArcPainter()),
                    ),
                  ),
                  // Logo inside circle
                  LogoWidget(size: logoSize * 0.8),
                ],

                // ---------- PHASE 2 ----------
                if (_controller.value > 0.5)
                  Center(
                    child: Transform.translate(
                      offset: Offset(
                        -screenWidth * 0.35 * ((_controller.value - 0.5) / 0.5),
                        0,
                      ),
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: Container(
                          width: logoSize,
                          height: logoSize,
                          alignment: Alignment.center,
                          child: LogoWidget(size: logoSize * 0.8),
                        ),
                      ),
                    ),
                  ),

                // ---------- PHASE 3 ----------
                if (_controller.value > 0.7)
                  Positioned(
                    left: -screenWidth * 0.15,
                    top: screenHeight * 0.5 - textHeight / 2,
                    child: FadeTransition(
                      opacity: _opacityAnimation,
                      child: LogoTextWidget(
                        width: textWidth,
                        height: textHeight,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 6.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final rect = Rect.fromCircle(center: center, radius: radius);

    final paint = Paint()
      ..shader = SweepGradient(
        startAngle: 0,
        endAngle: 2 * math.pi,
        colors: [
          Colors.blue.withValues(alpha: 0.0),
          Colors.blue.withValues(alpha: 1.0),
          Colors.blue.withValues(alpha: 0.0),
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(rect)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Centered arc
    canvas.drawArc(rect, 0, 2 * math.pi * 0.8, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
