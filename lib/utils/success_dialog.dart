import 'package:enrollment_system/pages/login.dart';
import 'package:enrollment_system/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessDialog extends StatelessWidget {
  final VoidCallback onClose; // Callback to remove blur when dialog is closed
  final String title;
  final String message;

  const SuccessDialog({Key? key,
    required this.onClose,
    required this.title,
    required this.message
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      backgroundColor: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 3), // Adjust color & thickness
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),// Ensure background is visible
        ]
        ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'lib/assets/images/checkmark.png',
              width: 120, // Adjust size as needed
              height: 120,
            ),
            SizedBox(height: 15),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            Text(
              // "Student enrollment request has been submitted. "
              //     "You will receive an email once verification is complete."
              message,
              style: GoogleFonts.poppins(fontSize: 14, color: Color(0xFF718096)),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  // Navigator.pop(context); // Close dialog
                  // onClose();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                },
                child: Text("Back to Login",
                style: GoogleFonts.poppins(
                  color: Colors.white
                ),
                ),
              ),
            ),
          ],
        ),
      ),
    )
    );
  }
}
