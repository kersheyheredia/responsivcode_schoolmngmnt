import 'package:enrollment_system/pages/grade_level_selection.dart';
import 'package:enrollment_system/pages/intro_page.dart';
import 'package:enrollment_system/pages/login.dart';
import 'package:enrollment_system/pages/parent/account_verification.dart';
import 'package:enrollment_system/pages/parent/register_parent.dart';
import 'package:enrollment_system/pages/parent_contact_details.dart';
import 'package:enrollment_system/pages/personal_details.dart';
import 'package:enrollment_system/pages/review_form.dart';
import 'package:flutter/material.dart';
import 'package:enrollment_system/utils/colors.dart';
import 'package:enrollment_system/pages/previous_school_details.dart';

void main() {
  runApp(MyApp());
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



