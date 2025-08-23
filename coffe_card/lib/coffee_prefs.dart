import 'package:coffe_card/styled_body_text.dart';
import 'package:coffe_card/styled_button.dart';
import 'package:flutter/material.dart';

class CoffePrefs extends StatefulWidget {
  const CoffePrefs({super.key});

  @override
  State<CoffePrefs> createState() => _CoffePrefsState();
}

class _CoffePrefsState extends State<CoffePrefs> {
  int coffeBean = 1;
  int sugarCubes = 0;

  void increaseStrength() {
    setState(() {
      coffeBean = coffeBean < 5 ? coffeBean + 1 : 1;
    });
  }

  void increaseSugar() {
    setState(() {
      sugarCubes = sugarCubes < 5 ? sugarCubes + 1 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const StyledBodyText('Strength: '),

            for (int i = 0; i < coffeBean; i++)
              Image.asset(
                'assets/img/coffee_bean.png',
                width: 25,
                color: Colors.brown[100],
                colorBlendMode: BlendMode.multiply,
              ),

            const Expanded(child: SizedBox()),
            StyledButton(onPressed: increaseStrength, child: const Text('+')),
          ],
        ),
        Row(
          children: [
            const StyledBodyText('Sugars: '),

            if (sugarCubes == 0) const StyledBodyText('No sugars...'),

            for (int i = 0; i < sugarCubes; i++)
              Image.asset(
                'assets/img/sugar_cube.png',
                width: 25,
                color: Colors.brown[100],
                colorBlendMode: BlendMode.multiply,
              ),

            const Expanded(child: SizedBox()),
            StyledButton(onPressed: increaseSugar, child: const Text('+')),
          ],
        ),
      ],
    );
  }
}
