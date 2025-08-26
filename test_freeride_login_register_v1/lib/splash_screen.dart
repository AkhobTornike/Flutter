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
  late AnimationController _logoScaleController;
  late AnimationController _logoMoveController;
  late AnimationController _fullLogoFadeController;
  bool _assetsPrecached = false;

  @override
  void initState() {
    super.initState();

    // Precache all images to ensure smooth transitions
    _precacheImages().then((_) {
      setState(() {
        _assetsPrecached = true;
      });

      // Start animations only after assets are loaded
      _startAnimations();
    });
  }

  Future<void> _precacheImages() async {
    final precache = [
      precacheImage(const AssetImage("assets/logo_icon.png"), context),
      precacheImage(const AssetImage("assets/logo_full.png"), context),
      precacheImage(const AssetImage("assets/logo.png"), context),
    ];

    await Future.wait(precache);
  }

  void _startAnimations() {
    // Arc rotation animation
    _arcController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Logo scale animation controller
    _logoScaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    // Logo move animation controller
    _logoMoveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Full logo fade animation controller
    _fullLogoFadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _startSplashSequence();
  }

  void _startSplashSequence() async {
    // Only start sequence if assets are loaded
    if (!_assetsPrecached) return;

    // Stage 0: Initial state with rotating arc (already showing)

    // Stage 1: Remove arc and show just the logo
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _currentSplash = 1);

    // Stage 2: Scale up the logo smoothly
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    _logoScaleController.forward(); // Start scale animation
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    setState(() => _currentSplash = 2);

    // Stage 3: Move logo to left and fade in full text logo on the right
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    _logoMoveController.forward(); // Start move animation
    _fullLogoFadeController.forward(); // Start full logo fade in
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() => _currentSplash = 3);

    // Navigate to login page
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LoginPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = 0.0;
          const end = 1.0;
          const curve = Curves.easeInOut;

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));
          return FadeTransition(opacity: animation.drive(tween), child: child);
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  void dispose() {
    _arcController.dispose();
    _logoScaleController.dispose();
    _logoMoveController.dispose();
    _fullLogoFadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_assetsPrecached) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
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
                Image.asset(
                  "assets/logo_icon.png",
                  width: 140, // Increased from 120
                  filterQuality: FilterQuality.high,
                ),
                SizedBox(
                  width: 170, // Increased from 150
                  height: 170, // Increased from 150
                  child: AnimatedBuilder(
                    animation: _arcController,
                    builder: (_, __) {
                      return Transform.rotate(
                        angle: _arcController.value * 2 * pi,
                        child: CustomPaint(
                          painter: ArcPainter(),
                          size: const Size(170, 170), // Increased from 150
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );

      case 1: // Stage 2: just logo (center)
        return Container(
          key: const ValueKey(1),
          color: Colors.white,
          child: Center(
            child: Image.asset(
              "assets/logo_icon.png",
              width: 140, // Increased from 120
              filterQuality: FilterQuality.high,
            ),
          ),
        );

      case 2: // Stage 3: bigger logo (center)
        return Container(
          key: const ValueKey(2),
          color: Colors.white,
          child: Center(
            child: ScaleTransition(
              scale: Tween(begin: 1.0, end: 280 / 140).animate(
                // Adjusted for new base size
                CurvedAnimation(
                  parent: _logoScaleController,
                  curve: Curves.easeInOut,
                ),
              ),
              child: Image.asset(
                "assets/logo_icon.png",
                width: 140, // Increased from 120
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        );

      case 3: // Stage 4: logo moves left and text logo fades in on the right
        return Container(
          key: const ValueKey(3),
          color: Colors.white,
          child: Stack(
            children: [
              // Text logo (logo_full.png) that fades in on the right side
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 30.0,
                  ), // Reduced from 40
                  child: AnimatedOpacity(
                    opacity: _fullLogoFadeController.value,
                    duration: const Duration(milliseconds: 600),
                    child: Image.asset(
                      "assets/logo_full.png",
                      width: 250, // Increased from 200
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
              ),

              // Moving icon logo to the left side
              Align(
                alignment: AlignmentTween(
                  begin: Alignment.center,
                  end: const Alignment(-0.8, 0.0), // Moved further left
                ).evaluate(_logoMoveController),
                child: ScaleTransition(
                  scale: Tween(begin: 280 / 140, end: 160 / 140).animate(
                    // Ends slightly larger
                    CurvedAnimation(
                      parent: _logoMoveController,
                      curve: Curves.easeInOut,
                    ),
                  ),
                  child: Image.asset(
                    "assets/logo_icon.png",
                    width: 140, // Increased from 120
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
            ],
          ),
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
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    // Draw arc (about 1/3 of circle)
    canvas.drawArc(rect, 0, pi * 1.3, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
