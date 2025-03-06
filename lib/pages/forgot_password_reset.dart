import 'dart:ui';

import 'package:enrollment_system/utils/colors.dart';
import 'package:enrollment_system/utils/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordReset extends StatefulWidget {
  const ForgotPasswordReset({super.key});

  @override
  State<ForgotPasswordReset> createState() => _ForgotPasswordResetState();
}

class _ForgotPasswordResetState extends State<ForgotPasswordReset> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool _isSubmitting = false; // Track submission state

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
          title: "Password Updated Successfully!",
          message: "Password changed successfully, you can login again with with new password. "

        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Icon(Icons.arrow_back_ios, color: AppColors.primaryColor),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 60),
                  Text(
                    "Forgot\nPassword",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: AppColors.primaryColor
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Reset your password",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 65),
                  Text(
                    "Your password must be different from previous used passwords",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildPasswordField('New Password',passwordController, _isPasswordVisible, () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  }),
                  SizedBox(height: 20),
                  _buildPasswordField('Confirm Password',confirmPasswordController, _isConfirmPasswordVisible, () {
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    });
                  }),
                  SizedBox(height: 100),
                  //BUTTON
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
                ],
              ),
            )
          )
        ],
      ),
    );
  }
  Widget _buildPasswordField(String hintText, TextEditingController controller, bool isVisible, VoidCallback toggleVisibility) {
    return TextField(
      controller: controller,
      obscureText: !isVisible,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
          onPressed: toggleVisibility,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

