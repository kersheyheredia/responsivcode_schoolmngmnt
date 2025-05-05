import 'package:enrollment_system/pages/model/subject.dart';
import 'package:enrollment_system/utils/calendar_of_activities.dart';
import 'package:enrollment_system/utils/colors.dart';
import 'package:enrollment_system/utils/custom_bottom_navbar.dart';
import 'package:enrollment_system/utils/custom_header_2.dart';
import 'package:enrollment_system/utils/custome_drawer.dart';
import 'package:enrollment_system/utils/top_header.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Subject> subjects = [];
  bool isLoading = true;
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
    fetchSubjects();
  }

  Future<void> fetchSubjects() async {
    await Future.delayed(Duration(seconds: 2)); // simulate loading delay
    setState(() {
      subjects = [
        Subject(title: 'Subject 1', percent: 0.89, color: Colors.green, note: 'no upcoming activities'),
        Subject(title: 'Subject 2', percent: 0.95, color: Colors.green, note: 'Math - Watch Fundamentals of Algebra'),
        Subject(title: 'Subject 3', percent: 0.42, color: Colors.red, note: 'no upcoming activities'),
        Subject(title: 'Subject 4', percent: 0.92, color: Colors.green, note: 'no upcoming activities'),
      ];
      isLoading = false;
    });
  }

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
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Text('Select Student:', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                  SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.10), // Faded border color with opacity
                          width: 1,
                        ),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.black.withOpacity(0.1), // Light shadow color
                        //     offset: Offset(0, 4), // Shadow direction (bottom)
                        //     blurRadius: 6, // Light blur radius for subtle shadow
                        //     spreadRadius: -1, // Negative value to restrict shadow spread
                        //   ),
                        // ],
                      ),

                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: 'Enmarada C. Salamancia - Grade 7',
                        onChanged: (value) {},
                        items: [
                          DropdownMenuItem(
                            value: 'Enmarada C. Salamancia - Grade 7',
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Enmarada C. Salamancia - Grade 7',
                                style: GoogleFonts.poppins(
                                  color: AppColors.primaryColor,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                        underline: SizedBox.shrink(), // Removes the underline
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView(
                padding: EdgeInsets.symmetric(horizontal: 12),
                children: [
                  // Building the list of subject cards
                  Column(
                    children: subjects.map((subject) {
                      return buildSubjectCard(subject);
                    }).toList(),
                  ),
                  // Activity Calendar
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ActivityCalendar(),
                  ),
                ],
              ),
            ),
            // CustomBottomNavigationBar(
            //   selectedIndex: _selectedIndex,
            //   onItemTapped: _onItemTapped,
            // ),
          ],
        ),
      ),
    );
  }

  // Building subject card widget
  Widget buildSubjectCard(Subject subject) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Top (Title + Progress Bar)
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Color(0xFF99C6E1),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.symmetric(vertical: 20),
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(
                subject.note,
                style: TextStyle(color: Colors.black87),
              ),
            ),
            // Top bar with progress
            Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Text(
                    'A- ${subject.title}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: LinearPercentIndicator(
                      lineHeight: 8,
                      percent: subject.percent,
                      progressColor: subject.color,
                      backgroundColor: AppColors.primaryColor,
                      barRadius: Radius.circular(4),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    '${(subject.percent * 100).toInt()}%',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
