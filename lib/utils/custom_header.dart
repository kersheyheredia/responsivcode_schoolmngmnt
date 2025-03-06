import 'package:enrollment_system/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Full width
      height: 100, // Increased height for better spacing
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, // Centers content horizontally
        children: [
          // University Logo
          Image.asset(
            'lib/assets/images/logo.png', // Replace with your image path
            height: 60,
          ),
          SizedBox(width: 16), // Space between logo and text
          // University Name and Address
          Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Centers text inside the column
            mainAxisAlignment: MainAxisAlignment.center, // Centers vertically
            children: [
              Text(
                "ResponsivCode University",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              Text(
                "301E-3, Medalle Bldg., Fuente Osmeña, Cebu City",
                style: TextStyle(
                  fontSize: 6,
                  color:AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
