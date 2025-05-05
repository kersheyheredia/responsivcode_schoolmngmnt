import 'package:enrollment_system/pages/class/enrollment_provider.dart';
import 'package:enrollment_system/pages/forgot_password_verification.dart';
import 'package:enrollment_system/pages/service/api_service.dart';
import 'package:enrollment_system/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MobileNumVerificationMethod extends StatefulWidget {
  const MobileNumVerificationMethod({super.key});

  @override
  State<MobileNumVerificationMethod> createState() => _MobileRecovery();
}

class _MobileRecovery extends State<MobileNumVerificationMethod> {
  final TextEditingController mobileNumController = TextEditingController();
  final TextEditingController userNumController = TextEditingController();
  String isResetPassword = '';


  @override
  Widget build(BuildContext context) {
    final enrollmentProvider = Provider.of<EnrollmentProvider>(context, listen: false);
    final ApiService apiService = ApiService();

    //String isPasswordReset = enrollmentProvider.isResetPass ?? '';
    String isPasswordReset = "1";
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
                    "Enter your user number & phone number for verification",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Ensure you enter a correct user number & phone number to proceed with verification.",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 40),
                  Text(
                    "User Number",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    //controller: userNumController,
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
                    onChanged: (value){
                      context.read<EnrollmentProvider>().setParentNumber(value);
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Mobile Number",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: mobileNumController,
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
                    onChanged: (value){
                      context.read<EnrollmentProvider>().setResetNumber(value);
                    },
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
                        onPressed:  () async{
                          isResetPassword = "1";
                          String parentNumber = enrollmentProvider.parentNumber;
                          String mobileNo = enrollmentProvider.resetNumber;
                          enrollmentProvider.setIsResetPassword(isResetPassword);

                          var result = await apiService.resetPassword(
                              parentNumber,
                              mobileNo,
                              isPasswordReset);

                          if (result != null && result.containsKey('error') && result['error']) {
                            // Handle error
                            print("Failed: ${result['message']}");
                            return;
                          }

                          if (result != null) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordVerification(

                                 //otp: result['otp'],  // Use OTP in next page

                            )));
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                                SnackBar(content: Text(
                                    "Failed!"))
                            );
                          }
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
