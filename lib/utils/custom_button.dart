import 'package:enrollment_system/utils/colors.dart';
import 'package:flutter/material.dart';
import '';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(0, 50),
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white, // Adjust text color if needed
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
