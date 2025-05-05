import 'package:enrollment_system/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  CustomBottomNavigationBar({
    required this.selectedIndex,
    required this.onItemTapped
    }
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20), // Elevates it above the screen bottom
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20), // Keeps it from touching the screen edges
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(0, 4), // Shadow below the navbar
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30), // Apply the rounding to navbar itself
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: onItemTapped,
            selectedItemColor: AppColors.primaryColor,
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
              BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Notifications"),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
            ],
          ),
        ),
      ),
    );
  }
}
