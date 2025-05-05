import 'package:flutter/material.dart';

class TopHeader extends StatelessWidget {
  final String title;
  const TopHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180, // Adjust the height as needed
      child: Stack(
        children: [
          Positioned(
              right: 0,
              top: 0,
              child: Image.asset('lib/assets/images/corner_design.png')),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20),
                Image.asset('lib/assets/images/logo.png', height: 80),
                SizedBox(height: 20),
                Text(
                  title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            top: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
