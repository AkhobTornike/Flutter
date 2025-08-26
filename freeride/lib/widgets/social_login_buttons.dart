import 'package:flutter/material.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Google
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              side: const BorderSide(color: Colors.grey),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/google_icon.png',
                  width: 20,
                  height: 20,
                ),
                const SizedBox(width: 10),
                const Text('შესვლა Google-ით'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 15),

        // Facebook
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              side: const BorderSide(color: Colors.grey),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/facebook_icon.png',
                  width: 20,
                  height: 20,
                ),
                const SizedBox(width: 10),
                const Text('შესვლა Facebook-ით'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 15),

        // Apple
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              side: const BorderSide(color: Colors.grey),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/apple_icon.png',
                  width: 20,
                  height: 20,
                ),
                const SizedBox(width: 10),
                const Text('შესვლა Apple-ით'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
