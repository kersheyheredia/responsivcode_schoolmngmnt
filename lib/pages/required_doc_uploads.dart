import 'package:enrollment_system/pages/grade_level_selection.dart';
import 'package:enrollment_system/pages/login.dart';
import 'package:enrollment_system/pages/personal_details.dart';
import 'package:enrollment_system/pages/previous_school_details.dart';
import 'package:enrollment_system/pages/review_form.dart';
import 'package:enrollment_system/utils/backward_button.dart';
import 'package:enrollment_system/utils/custom_header.dart';
import 'package:enrollment_system/utils/dob_picker.dart';
import 'package:enrollment_system/utils/upload_form_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:enrollment_system/utils/colors.dart';
import 'package:enrollment_system/utils/forward_button.dart';
import 'package:enrollment_system/utils/bottom_design.dart';
import 'package:enrollment_system/utils/step_progress_indicator.dart';


class RequiredDocUploads extends StatefulWidget {
  const RequiredDocUploads({super.key});

  @override
  State<RequiredDocUploads> createState() => _RequiredDocUploads();
}

class _RequiredDocUploads extends State<RequiredDocUploads> {
  bool isMiddleNameNA = false;
  bool isSuffixNA = false;
  int currentStep = 5;

  void nextStep() {
    if (currentStep < 5) {
      setState(() {
        currentStep++;
      });
    }
  }

  void previousStep() {
    if (currentStep > 1) {
      setState(() {
        currentStep--;
      });
    }
  }

  @override
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              /// **Header (Non-scrollable content)**
              CustomHeader(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Text(
                    "SCHOOL YEAR: YYYY-YYYY",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: CustomStepper(currentStep: currentStep),
              ),
              SizedBox(height: 30),
              /// **Scrollable Form Content**
              Expanded(
                child: Stack(
                  children: [
                    /// Background Image (Part of Scrollable Content)
                    Column(
                      children: [
                        SizedBox(height: 378.5), // Adjust height to position the image
                        BottomDesign(),
                      ],
                    ),
                    /// Foreground: Form Fields
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Upload Form 138 (Report Card)",
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: AppColors.primaryColor
                            ),
                          ),
                          SizedBox(height: 10),
                          UploadFormCard(
                            description: "Please upload a clear image or PDF of your From 138 (Report Cart)",
                            note: 'Ensure the file is readable and includes your full name and grades.Accepted formats: JPG, PNG, or PDF (Max 5MB)',
                            onPressed: (){
                            },
                          ),
                          SizedBox(height: 30),
                          Text(
                            "Upload Your ID Picture",
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: AppColors.primaryColor
                            ),
                          ),
                          SizedBox(height: 10),
                          UploadFormCard(
                            description: "Please upload a 2x2 ID picture with a white background.",
                            note: 'Your face must be clearly visible (no filters, sunglasses, or hats).'
                                'Accepted formats: JPG, PNG (Max 2MB)',
                            onPressed: (){
                            },
                          ),
                          SizedBox(height: 20),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RoundedBackArrowButton(
                                  onPressed: () {
                                    Navigator.push(context,MaterialPageRoute(builder: (context) => PreviousSchoolDetails()));
                                  },
                                  size: 50,
                                ),
                                RoundedArrowButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ReviewFormPage()));
                                  },
                                  size: 50,
                                ),
                              ]
                          )// Extra padding for better spacing
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
