import 'package:enrollment_system/pages/service/api_service.dart';
import 'package:enrollment_system/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomeDrawer extends StatefulWidget {
  const CustomeDrawer({super.key});

  @override
  State<CustomeDrawer> createState() => _CustomeDrawerState();
}

class _CustomeDrawerState extends State<CustomeDrawer> {
  String? fullName;
  String? userType;
  String? yearLevel;
  String? studentName;

  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    loadProfile();
  }
  String _formatUserType(String type) {
    switch (type) {
      case 'PARENTUSER':
        return 'Parent User';
      case 'ADMIN':
        return 'Administrator';
      case 'TEACHER':
        return 'Teacher';
      default:
        return type;
    }
  }

    Future<void> loadProfile() async {
    final profile = await apiService.fetchUserData();
    if (profile != null) {
      setState(() {
        fullName = profile['fullName'];
        userType = _formatUserType(profile['userType']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 750,
        child: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(16, 80, 16, 20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30, // Adjust the size as needed
                      backgroundImage: AssetImage('lib/assets/images/profile.png'),
                    ),
                    SizedBox(width: 12), // Adds spacing between profile and text
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fullName ?? "Loading...",
                          style: GoogleFonts.poppins(
                            color: AppColors.primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          userType!,
                          style: GoogleFonts.poppins(
                            color: AppColors.primaryColor,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //Divider(),
              ListTile(
                leading: Icon(Icons.add_circle_outline_rounded),
                title: Text("Add Student",
                  style: GoogleFonts.poppins(
                    color: AppColors.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.person_outline),
                title: Text("Grade 7 - Ikinamada C. Salamanca",
                  style: GoogleFonts.poppins(
                    color: AppColors.primaryColor,
                    fontSize: 12,
                  ),
                ),
              ),
              // Divider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListTile(
                    title: Center(
                      child: Text("Enrollment",
                        style: GoogleFonts.poppins(
                          color: AppColors.primaryColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Center(
                      child: Text("Assessment",
                        style: GoogleFonts.poppins(
                          color: AppColors.primaryColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Center(
                      child: Text("E-Grades",
                        style: GoogleFonts.poppins(
                          color: AppColors.primaryColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}
