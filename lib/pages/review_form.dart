import 'package:enrollment_system/pages/parent_contact_details.dart';
import 'package:enrollment_system/pages/required_doc_uploads.dart';
import 'package:enrollment_system/utils/backward_button.dart';
import 'package:enrollment_system/utils/bottom_design.dart';
import 'package:enrollment_system/utils/colors.dart';
import 'package:enrollment_system/utils/custom_header.dart';
import 'package:enrollment_system/utils/step_progress_indicator.dart';
import 'package:enrollment_system/utils/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:enrollment_system/utils/dropdown.dart';
import 'package:enrollment_system/utils/forward_button.dart';
import 'dart:ui';

class ReviewFormPage extends StatefulWidget {
  @override
  State<ReviewFormPage> createState() => _ReviewFormPageState();
}

class _ReviewFormPageState extends State<ReviewFormPage> {
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
            title: "Pre-Admission Successful",
            message: "Student enrollment request has been submitted. "
                "You will receive an email once verification is complete."
        );
      },
    );
  }
  // Sample Dynamic Data (Replace with Actual Data)
  final String schoolYear = "2024-2025";

  final String studentName = "Ikinamada C. Salamanca";

  final String gradeLevel = "Grade 7";

  final String entryStatus = "New";

  final String dateOfBirth = "June 20, 2009";

  final String placeOfBirth = "Cebu City";

  final String gender = "Female";

  final String age = "14";

  final String status = "Single";

  final String religion = "Roman Catholic";

  final String nationality = "Filipino";
 // Sample Incorrect Data
  final String schoolName = "University of ABCDEFGHJK";

  final String datesAttended = "YYYY-YYYY";

  final String lastGradeAttended = "Grade 6";

  final String guardianName = "Roger John Stephan Madez";

  final String address = "Forest Hills, Banawa Cebu City, Philippines, 6000";

  final String cellphoneNo = "+63 929 481 8194";

  final String landlineNo = "0000-0000";

  final String email = "rjsm@gmail.com";

  final String doc1Name = "Form 138 / Report Card";

  final String doc1Filename = "Form138.pdf";

  final String doc2Name = "2x2 ID Picture";

  final String doc2Filename = "IDminida.jpeg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              CustomHeader(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Center(

                ),
              ),
              Expanded(
                  child: SizedBox(
                    height:800,
                    child: SingleChildScrollView(
                      child: Stack(
                        children: [
                          /// Background Image (Part of Scrollable Content)
                          Column(
                            children: [
                              SizedBox(height: 800), // Adjust height to position the image
                              BottomDesign(),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Center(
                              child: Column(

                                children: [
                                  Text(
                                    "SCHOOL YEAR: $schoolYear Enrollment",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryColor,
                                    ),
                                  ), Text(
                                    "Review Form Entries",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Please review your information before submitting.\nYou can edit your entry by clicking the 'Back' button.",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        color: AppColors.primaryColor,
                                        fontStyle: FontStyle.italic
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  // Student Information

                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(2.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.4),
                                            blurRadius: 10,
                                            spreadRadius: 1,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                        padding: EdgeInsets.all(16),
                                        child: Image.asset(
                                          'lib/assets/images/person_icon.png',
                                          width: 50, // Adjust size as needed
                                          height: 50,
                                        )

                                      ),
                                      SizedBox(width: 16),
                                      Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              _studentName("Name:", studentName),
                                              SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  _detailsSection("Grade Level:", gradeLevel),
                                                  SizedBox(width: 30),
                                                  _detailsSection("Entry Status:", entryStatus),
                                                ],
                                              )
                                            ],
                                          )
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 20),

                                  // Personal Information
                                  _sectionTitle("Student Details"),
                                  _subSectionTitle("Personal Information"),
                                  SizedBox(height: 8),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 18),
                                    child: Row(
                                      children: [
                                        _detailsSection("Date of Birth: ", dateOfBirth),
                                        SizedBox(width: 50),
                                        _detailsSection("Place of Birth: ", placeOfBirth),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                 Padding(
                                   padding: const EdgeInsets.symmetric(horizontal: 18),
                                   child: Row(
                                     children: [
                                       _detailsSection("Gender: ", gender),
                                       SizedBox(width: 35),
                                       _detailsSection("Age: ", age),
                                       SizedBox(width: 35),
                                       _detailsSection("Status: ", status),
                                     ],
                                   ),
                                 ),
                                  SizedBox(height: 5),
                                 Padding(
                                   padding: const EdgeInsets.symmetric(horizontal: 18),
                                   child: Row(
                                     children: [
                                       _detailsSection("Religion: ", religion),
                                       SizedBox(width: 60),
                                       _detailsSection("Nationality: ", nationality),
                                     ],
                                   ),
                                 ),
                                  SizedBox(height: 30),

                                  // Previous School Attended
                                  _subSectionTitle("Previous School Attended"),
                                  SizedBox(height: 8),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 18),
                                    child: Align(
                                      alignment: Alignment.centerLeft, // Aligns details to the start (left)
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          _detailsSection("Name of School: ", "University of ABCDEFGHJK"),
                                          SizedBox(height: 5),
                                          _detailsSection("Dates Attended: ", "YYYY-YYYY"),
                                          SizedBox(height: 5),
                                          _detailsSection("Last Grade Attended: ", "Grade 6"),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 30),

                                  // Parent / Guardian Details
                                  _subSectionTitle("Parent/Guardian Details"),
                                  SizedBox(height: 10),
                                 Padding(
                                   padding: const EdgeInsets.symmetric(horizontal: 18),
                                   child: Align(
                                     alignment: Alignment.centerLeft,
                                     child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         _detailsSection("Parent/Guardian’s Name: ", guardianName),
                                         SizedBox(height: 5),
                                         _detailsSection("Address: ", address),
                                         SizedBox(height: 5),
                                         Row(
                                           children: [
                                             _detailsSection("Cellphone No.: ", cellphoneNo),
                                             SizedBox(width: 25),
                                             _detailsSection("Landline No.: ", landlineNo),
                                           ],
                                         ),
                                         SizedBox(height: 5),
                                         _detailsSection("Email: ", email),
                                       ],
                                     ),
                                   ),
                                 ),
                                  SizedBox(height: 30),
                                  _subSectionTitle("Uploaded Documents"),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      _detailsSection("Document: ", doc1Name),
                                      SizedBox(width: 30),
                                      _detailsSection("Filename: ", doc1Filename),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      _detailsSection("Document: ", doc2Name),
                                      SizedBox(width: 80),
                                      _detailsSection("Filename: ", doc2Filename),
                                    ],
                                  ),
                                  SizedBox(height: 50),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        RoundedBackArrowButton(
                                          onPressed: () {
                                            Navigator.push(context,MaterialPageRoute(builder: (context) => RequiredDocUploads()));
                                          },
                                          size: 50,
                                        ),
                                        ElevatedButton(
                                            onPressed: (){
                                             _submitReview();
                                            },
                                            style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.primaryColor, // Dark navy color
                                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12), // Adjust size
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10), // Rounded corners
                                              ),
                                            ),
                                            child: Text(
                                              "Submit",
                                              style: TextStyle(
                                                color: Colors.white, // White text
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                        )
                                      ]
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
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              )
            ],
          )
        ),
      )
    );
  }

  // Widget for section titles (bold)
  Widget _studentName(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
          children: [
            TextSpan(text: title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: AppColors.primaryColor)),
            TextSpan(
              text: " ",
            ),
            TextSpan(text: value, style: GoogleFonts.poppins(color: AppColors.primaryColor)),
          ],
        ),
      ),
    );
  }

  Widget _subSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
      ),
    );
  }

  // Widget for subsection titles
  Widget _detailsSection(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.poppins(fontSize: 10, color: Colors.black),
          children: [
            TextSpan(text: title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: AppColors.primaryColor)),
            TextSpan(
              text: " ",
            ),
            TextSpan(text: value, style: GoogleFonts.poppins(color: AppColors.primaryColor)),
          ],
        ),
      ),
    );
  }
}
