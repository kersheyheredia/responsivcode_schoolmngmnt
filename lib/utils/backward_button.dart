import 'package:flutter/material.dart';
import 'package:enrollment_system/utils/colors.dart';

class RoundedBackArrowButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double size; // Controls the width & height

  const RoundedBackArrowButton({
    Key? key,
    required this.onPressed,
    this.size = 50, // Default size
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor, // Dark navy blue
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        elevation: 6, // Shadow effect
        padding: EdgeInsets.zero, // Remove default padding
        minimumSize: Size(size, size), // Controls the button size
        maximumSize: Size(size, size), // Prevents it from expanding
      ),
      child: Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
        size: 18, // Icon size
      ),
    );
  }
}
