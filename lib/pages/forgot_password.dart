import 'package:enrollment_system/pages/email_recovery_method.dart';
import 'package:enrollment_system/pages/forgot_password_verification.dart';
import 'package:enrollment_system/pages/phonenum_verification_method.dart';
import 'package:enrollment_system/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPassword> {
  String? selectedMethod;

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
                  "Forgot\nPassword",
                  style: GoogleFonts.poppins(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
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
                SizedBox(height: 70),
                Text(
                  "Select a recovery method to proceed:",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(height: 20),

                // Email Option
                buildOption(
                  icon: Icons.email_outlined,
                  title: "Email",
                  subtitle: "********@mail.com",
                  value: "email",
                ),
                SizedBox(height: 15),

                // Phone Option
                buildOption(
                  icon: Icons.phone_outlined,
                  title: "Phone Number",
                  subtitle: "**** **** **** 2345",
                  value: "phone",
                ),
                SizedBox(height: 100),

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
                      onPressed: selectedMethod != null ? () {
                        if(selectedMethod == 'email'){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => EmailRecoveryMethod()));
                        }else if(selectedMethod == 'phone'){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MobileNumVerificationMethod()));
                        }
                      } : null,
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
              ],
            ),
          ),
        ],
      )
    );
  }

  // Widget for recovery options
  Widget buildOption({required IconData icon, required String title, required String subtitle, required String value}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMethod = value;
        });
      },
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedMethod == value ? AppColors.primaryColor : Colors.grey,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Icon(icon, size: 30, color: AppColors.primaryColor),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
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
