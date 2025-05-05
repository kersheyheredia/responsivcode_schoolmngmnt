import 'package:enrollment_system/pages/assessment.dart';
import 'package:enrollment_system/pages/class/enrollment_provider.dart';
import 'package:enrollment_system/pages/dashboard.dart';
import 'package:enrollment_system/pages/dummy.dart';
import 'package:enrollment_system/pages/e_grades.dart';
import 'package:enrollment_system/pages/enrollment_process.dart';
import 'package:enrollment_system/pages/home_page.dart';
import 'package:enrollment_system/pages/home_screen.dart';
import 'package:enrollment_system/pages/login.dart';
import 'package:enrollment_system/pages/notification_page.dart';
import 'package:enrollment_system/pages/profile_page.dart';
import 'package:enrollment_system/pages/subject_selection.dart';
import 'package:flutter/material.dart';
import 'package:enrollment_system/utils/colors.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (context)=>EnrollmentProvider(),
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primaryColor, // Set background color globally
          toolbarHeight: 10, // Set fixed height
          elevation: 0,
        ),
      ),
      home: Login()

    );
  }
}


