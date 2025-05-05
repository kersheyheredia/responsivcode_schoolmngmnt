import 'package:enrollment_system/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:enrollment_system/pages/dashboard.dart';
import 'package:enrollment_system/pages/notification_page.dart';
import 'package:enrollment_system/pages/profile_page.dart';
import 'package:enrollment_system/pages/home_page.dart'; // newly created file
import 'package:enrollment_system/utils/custom_bottom_navbar.dart';
import 'package:enrollment_system/utils/custome_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    Dashboard(),
    NotificationPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      //drawer: CustomeDrawer(),

      //backgroundColor: Colors.white,
      body: SafeArea(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
