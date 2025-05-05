import 'package:enrollment_system/pages/forgot_password_verification.dart';
import 'package:enrollment_system/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailRecoveryMethod extends StatefulWidget {
  const EmailRecoveryMethod({super.key});

  @override
  State<EmailRecoveryMethod> createState() => _EmailRecovery();
}

class _EmailRecovery extends State<EmailRecoveryMethod> {
  final TextEditingController emailController = TextEditingController();

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
                    "Enter your email for verification",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Ensure you enter a valid email to proceed with verification.",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: emailController,
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
                        onPressed:  () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordVerification()));
                        } ,
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
}
