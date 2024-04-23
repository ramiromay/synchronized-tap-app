import 'package:flutter/material.dart';

class BackgroundSliver extends StatelessWidget {
  const BackgroundSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        child: Image.asset(
          'assets/sushi.jpg',
          fit: BoxFit.cover,
          colorBlendMode: BlendMode.darken,
          color: Colors.black.withOpacity(0.2),
        ),
    );
  }
}
