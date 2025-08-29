import 'package:flutter/material.dart';

class WeatherWidget extends StatefulWidget {
  final bool isExpanded;
  final VoidCallback? onToggle;
  const WeatherWidget({super.key, this.isExpanded = false, this.onToggle});

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpanded;
  }

  void _toggle() {
    setState(() => _isExpanded = !_isExpanded);
    widget.onToggle?.call();
  }

  @override
  Widget build(BuildContext context) {
    final double collapsedHeight = 55;
    final double expandedHeight = MediaQuery.of(context).size.height * 0.535;

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        height: _isExpanded ? expandedHeight : collapsedHeight,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFF56CCF2), Color(0xFF2F80ED)],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 12,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: Column(
          children: [
            // Handle with swipe support
            GestureDetector(
              onTap: _toggle,
              child: Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 6),
                child: Container(
                  width: 50,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),

            if (!_isExpanded)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'ამინდი',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            else
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  child: Column(
                    children: [
                      const Text(
                        'ბახმარო',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const _CountryChip(text: 'საქართველო'),
                      const SizedBox(height: 8),
                      const Icon(
                        Icons.wb_sunny,
                        size: 80,
                        color: Colors.amber,
                      ), // smaller
                      const SizedBox(height: 4),
                      const Text(
                        '15°C',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32, // smaller than before
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'უსაფრთხო',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          SizedBox(width: 6),
                          _Dot(color: Color(0xFF00C711)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Divider(color: Colors.white24, thickness: 0.6),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          _Stat(
                            icon: Icons.air,
                            value: '12 mph',
                            label: 'ქარი',
                          ),
                          _Stat(
                            icon: Icons.water_drop,
                            value: '67%',
                            label: 'ნალექი',
                          ),
                          _Stat(
                            icon: Icons.waves,
                            value: '51%',
                            label: 'ტენიანობა',
                          ),
                          _Stat(
                            icon: Icons.visibility,
                            value: '4 mi',
                            label: 'ნისლი',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _CountryChip extends StatelessWidget {
  final String text;
  const _CountryChip({required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 10),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final Color color;
  const _Dot({required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 7,
      height: 7,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _Stat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  const _Stat({required this.icon, required this.value, required this.label});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24), // smaller
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 9)),
      ],
    );
  }
}
