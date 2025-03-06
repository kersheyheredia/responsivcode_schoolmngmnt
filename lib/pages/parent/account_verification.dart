import 'dart:ui';

import 'package:enrollment_system/pages/forgot_password_reset.dart';
import 'package:enrollment_system/pages/forgot_password_verification.dart';
import 'package:enrollment_system/pages/login.dart';
import 'package:enrollment_system/utils/colors.dart';
import 'package:enrollment_system/utils/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountVerification extends StatefulWidget {
  const AccountVerification({super.key});

  @override
  State<AccountVerification> createState() => _AccountVerificationScreenState();
}

class _AccountVerificationScreenState extends State<AccountVerification> {
  bool _isSubmitting = false;
  String? selectedMethod;
  List<String> otp = ["", "", "", ""]; // Stores entered OTP
  int currentIndex = 0; // Tracks current OTP input position

  // Function to handle keypress from the custom keypad
  void _onKeyPressed(String value) {
    setState(() {
      if (value == "⌫") {
        // Delete last digit
        if (currentIndex > 0) {
          currentIndex--;
          otp[currentIndex] = "";
        }
      } else if (currentIndex < 4) {
        otp[currentIndex] = value;
        currentIndex++;
      }
    });
  }
  void _submitReview() {
    setState(() {
      _isSubmitting = true;//Show blur & dialog
    });
    _showSuccessDialog();
  }
  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return SuccessDialog(
            onClose: () {
              setState(() {
                _isSubmitting = false; // Remove blur when dialog is dismissed
              });
            },
            title: "We are verifying your account!",
            message: "For security purposes, we are verifying your account. Please ensure the student’s ID number and name are correct. You will receive an email once the verification is complete."

        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Icon(Icons.arrow_back_ios, color: AppColors.primaryColor),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 60),
                  Text(
                    "Verify\nAccount",
                    style: GoogleFonts.poppins(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Email and Student Verification",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 70),
                  Text(
                    "Enter the verification code that we have sent to your email",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      return Container(
                        width: 50,
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: index == currentIndex ? Colors.blue : Colors.black26,
                            width: 2,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          otp[index],
                          style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 10),
                  // Resend Code
                  TextButton(
                    onPressed: () {
                      // Resend OTP functionality
                    },
                    child: Center(
                      child: Text(
                        "Resend Code",
                        style: GoogleFonts.poppins(fontSize: 16, color: Colors.blue, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),// Custom Keypad
                  Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.5,
                      ),
                      itemCount: 12,
                      itemBuilder: (context, index) {
                        List<String> keys = [
                          "1", "2", "3",
                          "4", "5", "6",
                          "7", "8", "9",
                          ".", "0", "⌫"
                        ];
                        return GestureDetector(
                          onTap: () => _onKeyPressed(keys[index]),
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              keys[index],
                              style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w500),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Continue Button
                  Center(
                    child: SizedBox(
                      //width: double.minPositive,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(0, 50),
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: (){
                          _submitReview();
                        },
                        child: Text(
                          "Continue",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                  ),
                  if (_isSubmitting)
                    Positioned.fill(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Apply blur
                        child: Container(color: Color(0xC8C8C8).withAlpha(20)), // Slight overlay
                      ),
                    ),
                  SizedBox(height: 15)
                ],
              ),
            ),
          ],
        )
    );
  }
}
