import 'dart:io';

import 'package:enrollment_system/pages/parent_contact_details.dart';
import 'package:enrollment_system/pages/required_doc_uploads.dart';
import 'package:enrollment_system/utils/backward_button.dart';
import 'package:enrollment_system/utils/bottom_design.dart';
import 'package:enrollment_system/utils/colors.dart';
import 'package:enrollment_system/utils/custom_header.dart';
import 'package:enrollment_system/utils/step_progress_indicator.dart';
import 'package:enrollment_system/utils/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:enrollment_system/utils/dropdown.dart';
import 'package:enrollment_system/utils/forward_button.dart';
import 'dart:ui';
import 'package:provider/provider.dart';
import 'service/api_service.dart';
import 'package:enrollment_system/pages/class/enrollment_provider.dart'; // Import your provider

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

  @override
  Widget build(BuildContext context) {
    final enrollmentProvider = Provider.of<EnrollmentProvider>(context);
    final ApiService apiService = ApiService();

    String userType = enrollmentProvider.userType ?? '';
    String first_name = enrollmentProvider.parentFirstName ?? '';
    String last_name = enrollmentProvider.parentLastName ?? '';
    String? guardianSuffix = enrollmentProvider.parentSuffix;
    String? guardianMiddleName = enrollmentProvider.parentMiddleName;
    String? guardianGender = enrollmentProvider.parentGender;
    String prefix = "sample";
    String displayName = "kim";
    String _status = "active";
    String guardianBPlace = "cebu";
    String guardianReligion="catholic";
    String? guardianCivilStatus = enrollmentProvider.civilStat;
    String? guardianDOB = enrollmentProvider.parentDOB;
    String? mobileNo = enrollmentProvider.cellNo;
    String? telephoneNo = enrollmentProvider.landlineNo;
    String? guardianEmail = enrollmentProvider.email;
    String studentFName = enrollmentProvider.studentFirstName ?? '';
    String studentLName = enrollmentProvider.studentLastName ?? '';
    String bMonth = enrollmentProvider.studentBMonth ?? '';
    String bDay = enrollmentProvider.studentBDay ?? '';
    String bYear = enrollmentProvider.studentBYear ?? '';
    Object guardianHouse = enrollmentProvider.houseNo ?? '';
    Object guardianStreet = enrollmentProvider.street ?? '';
    Object barangay = enrollmentProvider.barangay ?? '';
    Object city = enrollmentProvider.city ?? '';
    Object zipCode = enrollmentProvider.zipCode ?? '';
    String guardianName = '$first_name ' '$last_name';
    String gradeLevel = enrollmentProvider.gradeLevel ?? '';
    String entryStatus = enrollmentProvider.status ?? '';
    String schoolYear = "";
    String studentName = '$studentFName ' '$studentLName';
    String dateOfBirth = '$bMonth/' '$bDay/' '$bYear';
    String placeOfBirth = enrollmentProvider.studentBPlace;
    String gender = enrollmentProvider.studentGender;
    String age = enrollmentProvider.studentAge;
    String status = enrollmentProvider.studentCivilStat;
    String religion = enrollmentProvider.studentReligion;
    String nationality = enrollmentProvider.studentNationality;
    String schoolName = enrollmentProvider.nameOfSchool;
    String datesAttended = enrollmentProvider.dateAttended;
    String lastGradeAttended = enrollmentProvider.gradeCompleted;
    String address = '$guardianHouse ' '$guardianStreet ' '$barangay, ' ' $city, ' '$zipCode';
    String cellphoneNo = enrollmentProvider.cellNo ?? '';
    String landlineNo = enrollmentProvider.landlineNo ?? '';
    String email = enrollmentProvider.email;
    String doc1Name = "Form138";
    String? doc1Filename = enrollmentProvider.fileName;
    String doc2Name = "2x2 ID";
    String? doc2Filename = enrollmentProvider.picFileName;

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
                                          _detailsSection("Name of School: ", schoolName),
                                          SizedBox(height: 5),
                                          _detailsSection("Dates Attended: ", datesAttended),
                                          SizedBox(height: 5),
                                          _detailsSection("Last Grade Attended: ", lastGradeAttended),
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

                                 Padding(
                                     padding: const EdgeInsets.symmetric(horizontal:  18),
                                 child: Align(
                                   alignment: Alignment.centerLeft,
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       //for form 138
                                       _buildFileDisplay(
                                         context,
                                         label: 'Form 138',
                                         fileName: enrollmentProvider.fileName,
                                         filePath: enrollmentProvider.formFile?.path,
                                       ),
                                       SizedBox(height: 5),
                                       //for ID
                                       _buildFileDisplay(
                                         context,
                                         label: '2x2 Picture',
                                         fileName: enrollmentProvider.picFileName,
                                         filePath: enrollmentProvider.picFile?.path,
                                       ),
                                     ],
                                   ),
                                 ),
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
                                            onPressed: () async {
                                             _submitReview();

                                               bool success = await apiService.registerParent(
                                                   guardianName,
                                                   first_name,
                                                   last_name,
                                                   address,
                                                   cellphoneNo,
                                                   email,
                                                   studentName
                                               );
                                             if (success) {
                                               _showSuccessDialog();
                                               ScaffoldMessenger.of(context).showSnackBar(
                                                   SnackBar(content: Text("Pre-admission submitted successfully!"))
                                               );
                                             } else {
                                               setState(() {
                                                 _isSubmitting = false;
                                               });
                                               ScaffoldMessenger.of(context).showSnackBar(
                                                   SnackBar(content: Text("Pre-admission submission failed!"))
                                               );
                                             }

                                               // if(parent_id != null){
                                               //   await apiService.registerStudent(
                                               //     parent_id.toString(),  // You can also change registerStudent to accept int
                                               //     studentName,
                                               //   );
                                               //   _showSuccessDialog();
                                               //   ScaffoldMessenger.of(context)
                                               //       .showSnackBar(
                                               //       SnackBar(content: Text(
                                               //           "Parent registration successful!"))
                                               //   );
                                               // } else {
                                               //   setState(() {
                                               //     _isSubmitting =
                                               //     false; // Remove blur on failure
                                               //   });
                                               //   ScaffoldMessenger.of(context)
                                               //       .showSnackBar(
                                               //       SnackBar(content: Text(
                                               //           "Parent registration failed!"))
                                               //   );
                                               // // }
                                             //hfjdb
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

//for the file upload
Widget _buildFileDisplay(
    BuildContext context, {
      required String label,
      required String? fileName,
      required String? filePath,
    }) {
  if (fileName == null || filePath == null) {
    return Text('$label: No file uploaded.');
  }

  String extension = fileName.split('.').last.toLowerCase();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      GestureDetector(
        onTap: () =>  _previewFile(context, filePath, extension),
        // child: Text(
        //   '$label: $fileName',
        //   style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
        // ),
        child: RichText(
          text: TextSpan(
            style: GoogleFonts.poppins(fontSize: 10, color: Colors.black),
            children: [
              TextSpan(text: '$label:', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: AppColors.primaryColor)),
              TextSpan(
                text: " ",
              ),
              TextSpan(text: fileName, style: GoogleFonts.poppins(color: AppColors.primaryColor)),
            ],
          ),
        ),
      )
    ],
  );
}

// File Preview Logic
void _previewFile(BuildContext context, String filePath, String extension) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      insetPadding: EdgeInsets.zero,
      child: Container(
        padding: const EdgeInsets.all(12),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: extension == 'pdf'
            ? PDFView(
          filePath: filePath,
          enableSwipe: true,
          swipeHorizontal: false,
          autoSpacing: true,
          pageFling: true,
        )
            : extension == 'jpg' || extension == 'png'  || extension == 'jpeg'
            ? Image.file(File(filePath))
            : const Center(
          child: Text("Cannot preview this file type"),
        ),
      ),
    ),
  );
}