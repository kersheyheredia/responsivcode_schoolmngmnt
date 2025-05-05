import 'package:enrollment_system/pages/class/enrollment_provider.dart';
import 'package:enrollment_system/pages/forgot_password_reset.dart';
import 'package:enrollment_system/pages/forgot_password_verification.dart';
import 'package:enrollment_system/pages/login.dart';
import 'package:enrollment_system/pages/service/api_service.dart';
import 'package:enrollment_system/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ForgotPasswordVerification extends StatefulWidget {
  const ForgotPasswordVerification({
    super.key,
    //required otp
  });

  @override
  State<ForgotPasswordVerification> createState() => _ForgotPasswordVerificationScreenState();
}

class _ForgotPasswordVerificationScreenState extends State<ForgotPasswordVerification> {
  String? selectedMethod;
  List<String> otpp = ["", "", "", "", "", ""]; // Stores entered OTP
  int currentIndex = 0; // Tracks current OTP input position

  // Function to handle keypress from the custom keypad
  void _onKeyPressed(String value) {
    setState(() {
      if (value == "⌫") {
        // Delete last digit
        if (currentIndex > 0) {
          currentIndex--;
          otpp[currentIndex] = "";
        }
      } else if (currentIndex < 6) {
        otpp[currentIndex] = value;
        currentIndex++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final enrollmentProvider = Provider.of<EnrollmentProvider>(context, listen: false);
    final ApiService apiService = ApiService();
    String parentNumber = enrollmentProvider.parentNumber;
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
                    "Verification Code",
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
                    children: List.generate(6, (index) {
                      return Container(
                        width: 30,
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: index == currentIndex ? Colors.blue : Colors.black26,
                            width: 1,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          otpp[index],
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
                        onPressed: () async {
                          // Combine user-entered OTP into a single string
                          String enteredOtp = otpp.join();
                            // ✅ Navigate to the reset password page if OTP is valid
                          enrollmentProvider.setOtp(enteredOtp);


                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPasswordReset(),
                              ),
                            );
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
                ],
              ),
            ),
          ],
        )
    );
  }
}
