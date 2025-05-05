import 'package:enrollment_system/utils/colors.dart';
import 'package:enrollment_system/utils/custom_bottom_navbar.dart';
import 'package:enrollment_system/utils/custom_header_2.dart';
import 'package:enrollment_system/utils/custome_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationState();
}

class _NotificationState extends State<NotificationPage>
    with SingleTickerProviderStateMixin{
  TabController? _tabController;
  // int _selectedIndex = 0;
  //
  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  final selectedColor = AppColors.primaryColor; // Dark text for "All"
  final unselectedColor = Colors.blueGrey[200]; // Faded color for others

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //appBar: AppBar(),
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
              //tabs
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.transparent, // Hides the extra line
                      width: 0,
                    ),
                  ),
                ),
                child: TabBar(
                  controller: _tabController!,
                  tabs: const [
                    Tab(text: "All"),
                    Tab(text: "Read"),
                    Tab(text: "Unread"),
                  ],
                  labelColor: selectedColor,
                  unselectedLabelColor: unselectedColor,
                  labelStyle: const TextStyle(
                    fontSize: 16,
                    //fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                  //indicator: const BoxDecoration(), // empty decoration = no underline
                 // indicatorColor: Colors.transparent,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: TabBarView(
                  controller: _tabController!,
                  children: const [
                    Center(child: Text("All Messages")),
                    Center(child: Text("Read Messages")),
                    Center(child: Text("Unread Messages")),
                  ],
                ),
              ),
              // CustomBottomNavigationBar(
              //   selectedIndex: _selectedIndex,
              //   onItemTapped: _onItemTapped,
              // ),
            ],
          )
      )
    );
  }
}
