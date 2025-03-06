import 'package:flutter/material.dart';

class TopDesign extends StatelessWidget {
  const TopDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0, // Ensures it starts at the leftmost part
      right: 0, // Extends it to the rightmost part
      child: Image.asset(
        'lib/assets/images/logo.png',
        width: double.infinity, // Full width
        fit: BoxFit.cover, // Ensures it stretches correctly
      ),
    );
  }
}

