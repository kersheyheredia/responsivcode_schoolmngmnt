import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:enrollment_system/pages/class/enrollment_provider.dart';
import 'package:enrollment_system/pages/forgot_password.dart';
import 'package:enrollment_system/pages/grade_level_selection.dart';
import 'package:enrollment_system/pages/parent_contact_details.dart';
import 'package:enrollment_system/utils/bottom_design.dart';
import 'package:enrollment_system/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({
    super.key,
  });
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final ApiService apiService = ApiService();
  bool firstSwitchValue = false;
  bool isChecked = false;
  String textFieldLabel = "Student Number";
  final TextEditingController parentNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool savePassword = false;


  @override
  void initState() {
    super.initState();
    _loadSavedPassword();
  }

  //login existing user
  Future<bool> postData() async {
    String username = parentNumberController.text.trim();
    String password = passwordController.text.trim();
    if (username.isNotEmpty && password.isNotEmpty) {
      bool isSuccess = await apiService.postData(username, password);

      if (isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Data sent!")),
        );
        return true; // ✅ Return success
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to send data!")),
        );
        return false; // ✅ Return failure
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill out all fields!")),
      );
      return false; // ✅ Return false when fields are empty
    }
  }
  // Load saved password from SharedPreferences
  Future<void> _loadSavedPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      savePassword = prefs.getBool('save_password') ?? false;
      if (savePassword) {
        passwordController.text = prefs.getString('saved_password') ?? '';
      }
    });
  }
  // Save or remove password based on checkbox state
  Future<void> _handleSavePassword(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      savePassword = value;
    });

    if (savePassword) {
      await prefs.setString('saved_password', passwordController.text);
      await prefs.setBool('save_password', true);
    } else {
      await prefs.remove('saved_password');
      await prefs.setBool('save_password', false);
    }
  }
  @override
  Widget build(BuildContext context) {
    final enrollmentProvider = Provider.of<EnrollmentProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(),
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 620), // Adjust height to position the image
                          BottomDesign(),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 0),
                            // Logo Image
                            Image.asset(
                              'lib/assets/images/logo.png',
                              height: 150,
                              width: 150,
                            ),
                            const SizedBox(height: 10),
                            // Login Text
                            Text(
                              'LOGIN',
                              style: GoogleFonts.poppins(
                                fontSize: 30,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Toggle Switch
                            AnimatedToggleSwitch<bool>.size(
                              current: firstSwitchValue,
                              values: const [false, true],
                              iconOpacity: 1.0,
                              indicatorSize: const Size.fromWidth(100),
                              customIconBuilder: (context, local, global) => Text(
                                local.value ? 'Parent' : 'Student',
                                style: GoogleFonts.poppins(
                                  color: local.value == global.current
                                      ? Colors.white
                                      : const Color(0xFF011839),
                                ),
                              ),
                              borderWidth: 5.0,
                              iconAnimationType: AnimationType.onHover,
                              style: ToggleStyle(
                                indicatorColor: AppColors.primaryColor,
                                borderColor: Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: AppColors.primaryColor,
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: Offset(0, 8),
                                  )
                                ],
                              ),
                              selectedIconScale: 1.0,
                              onChanged: (value) =>
                                  setState(() {
                                    firstSwitchValue = value;
                                    enrollmentProvider.setUserType((value ? 3:2));
                                    textFieldLabel = value ? "Parent Number" : "Student Number";
                                  })
                            ),
                            const SizedBox(height: 20),
                            // ID Number Input
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                textFieldLabel,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF011839),
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: parentNumberController,
                              decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF011839), width: 1.0),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF011839), width: 2.0),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            // Password Input
                            Align(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'Password',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF011839),
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: passwordController,
                              decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF011839), width: 1.0),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF011839), width: 2.0),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            // Checkbox and Forgot Password
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              // Ensures proper alignment
                              children: [
                                // Wrap Checkbox and Text in a Row to ensure they are close
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  // Prevents extra spacing
                                  children: [
                                    Checkbox(
                                      value: savePassword,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _handleSavePassword(value ?? false);
                                        });
                                      },
                                      activeColor: AppColors.primaryColor,
                                      materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                      // Reduce default padding
                                      visualDensity: VisualDensity(
                                          horizontal: -4,
                                          vertical:
                                          -4), // Makes checkbox smaller and aligned
                                    ),
                                    const SizedBox(width: 5),
                                    // Reduce spacing between Checkbox and text
                                    const Text(
                                      'Save Password',
                                      style: TextStyle(
                                        color: Color(0xFF011839),
                                      ),
                                    ),
                                  ],
                                ),

                                const Spacer(),
                                // Push "Forgot Password?" to the right

                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ForgotPassword()));
                                  },
                                  child: const Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                      color: Color(0xFF011839),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            // Elevated Button for Login
                            SizedBox(
                              //width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () async {
                                  bool isSuccess = await postData();
                                  if (isSuccess) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                GradeLevelSelection()),
                                      );
                                    });
                                  }
                                },
                                child: Text(
                                  'LOGIN',
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Pre-Admission Now Open!',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(width: 10),
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                GradeLevelSelection()));
                                  },
                                  child: Text(
                                    'Enroll Now!',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration
                                          .underline, // Optional: Adds an underline
                                    ),
                                  ),
                                )
                              ],
                            ),
                            //SizedBox(height: 80),
                          ],
                        ),
                      ),
                     // BottomDesign(),
                    ],
                  ),

                )
            )
          ],
        )
    );
  }
}
