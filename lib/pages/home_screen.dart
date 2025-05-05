import 'package:enrollment_system/pages/dashboard.dart';
import 'package:enrollment_system/pages/notification_page.dart';
import 'package:enrollment_system/pages/profile_page.dart';
import 'package:enrollment_system/utils/colors.dart';
import 'package:enrollment_system/utils/custom_header_2.dart';
import 'package:enrollment_system/utils/custome_drawer.dart';
import 'package:flutter/material.dart';
import 'package:enrollment_system/utils/custom_header.dart';
import 'package:enrollment_system/utils/custom_bottom_navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  // int _selectedIndex = 0;
  //
  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
        drawer: CustomeDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            Builder(
              builder: (context) => CustomHeader2(
                onMenuPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
            Expanded(
                child:  SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset('lib/assets/images/gradpic.jpg', fit: BoxFit.cover),
                      SizedBox(height: 10),
                      _buildCard('lib/assets/images/classrm.jpg', 'Apply for Scholarship'),
                      _buildCard('lib/assets/images/event.jpg', 'View event details'),
                      _buildCard('lib/assets/images/school_clubs.jpg', 'View School Clubs')
                    ],
                  ),
                ),
            ),
          ],
        ),
      ),

      // bottomNavigationBar: CustomBottomNavigationBar(
      //   selectedIndex: _selectedIndex,
      //   onItemTapped: _onItemTapped,
      // ),
    );
  }
  Widget _buildCard(String imagePath, String buttonText){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                  imagePath, fit:
                  BoxFit.cover,
                  width: double.infinity,
                  height: 250),
            ),
            Positioned(
                bottom: 10,
                right: 10,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor),
                    onPressed: (){},
                    child: Text(buttonText, style: TextStyle(color: Colors.white))
                )
            )
          ],
        ),
      )
    );
  }
}

