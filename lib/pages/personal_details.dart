import 'package:enrollment_system/pages/class/enrollment_provider.dart';
import 'package:enrollment_system/pages/grade_level_selection.dart';
import 'package:enrollment_system/pages/login.dart';
import 'package:enrollment_system/pages/parent_contact_details.dart';
import 'package:enrollment_system/pages/previous_school_details.dart';
import 'package:enrollment_system/utils/backward_button.dart';
import 'package:enrollment_system/utils/custom_header.dart';
import 'package:enrollment_system/utils/dob_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:enrollment_system/utils/colors.dart';
import 'package:enrollment_system/utils/forward_button.dart';
import 'package:enrollment_system/utils/bottom_design.dart';
import 'package:enrollment_system/utils/step_progress_indicator.dart';
import 'package:provider/provider.dart';


class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetails();
}

class _PersonalDetails extends State<PersonalDetails> {
  bool isMiddleNameNA = false;
  bool isSuffixNA = false;
  TextEditingController middleNameController = TextEditingController();
  TextEditingController suffixController = TextEditingController();
  int currentStep = 3;

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

  void _validateAndProceed(int step) {
    final enrollmentProvider = Provider.of<EnrollmentProvider>(context, listen: false);

    if (!enrollmentProvider.validate(step)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please fill in all required fields."),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => PreviousSchoolDetails()));
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
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      /// Background Image (Part of Scrollable Content)
                      Column(
                        children: [
                          SizedBox(height: 720), // Adjust height to position the image
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
                              "Student Details",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            const SizedBox(height: 15),
                            buildTextField("First Name", (value) => context.read<EnrollmentProvider>().setStudentFirstName(value)),
                            const SizedBox(height: 15),
                            buildTextField("Last Name", (value) => context.read<EnrollmentProvider>().setStudentLastName(value)),
                            const SizedBox(height: 15),

                            /// Middle Name & Suffix
                            Row(
                              children: [
                                Expanded(flex: 2, child: buildTextField("Middle Name",
                                  controller: middleNameController,
                                  (value) => context.read<EnrollmentProvider>().setStudentMiddleName(value),
                                  enabled: !isMiddleNameNA,)),
                                const SizedBox(width: 10),
                                Expanded(child: buildTextField("Suffix",
                                        controller: suffixController,
                                        (value) => context.read<EnrollmentProvider>().setStudentSuffix(value),
                                        enabled: !isSuffixNA)),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: isMiddleNameNA,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isMiddleNameNA = value ?? false;
                                      middleNameController.text = isMiddleNameNA ? "N/A" : "";
                                    });
                                    context.read<EnrollmentProvider>().toggleStudentMiddleName(isMiddleNameNA);
                                  },
                                  activeColor: AppColors.primaryColor,
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  'Not Applicable',
                                  style: GoogleFonts.poppins(
                                    color: Color(0xFF011839),
                                    fontSize: 10,
                                  ),
                                ),
                                SizedBox(width: 125),
                                Checkbox(
                                  value: isSuffixNA,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isSuffixNA = value ?? false;
                                      suffixController.text = isSuffixNA ? "N/A" : "";
                                    });
                                    context.read<EnrollmentProvider>().toggleStudentSuffix(isSuffixNA);
                                  },
                                  activeColor: AppColors.primaryColor,
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  'Not Applicable',
                                  style: GoogleFonts.poppins(
                                    color: Color(0xFF011839),
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            DateOfBirthPicker(
                                onDateSelected: (month, day, year){
                                  context.read<EnrollmentProvider>().setStudentBMonth(month);
                                  context.read<EnrollmentProvider>().setStudentBDay(day);
                                  context.read<EnrollmentProvider>().setStudentBYear(year);
                                }
                            ),
                            const SizedBox(height: 15),
                            buildTextField("Birth Place", (value)=> context.read<EnrollmentProvider>().setStudentBPlace(value)),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(child: buildTextField("Age", (value)=> context.read<EnrollmentProvider>().setStudentAge(value))),
                                const SizedBox(width: 10),
                                Expanded(flex: 2,
                                    child: buildTextField("Gender",(value)=> context.read<EnrollmentProvider>().setStudentGender(value))),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(child: buildTextField("Religion", (value)=> context.read<EnrollmentProvider>().setStudentReligion(value))),
                                const SizedBox(width: 10),
                                Expanded( child: buildTextField("Status",(value)=> context.read<EnrollmentProvider>().setStudentStatus(value))),
                              ],
                            ),
                            const SizedBox(height: 15),
                            buildTextField("Nationality", (value)=> context.read<EnrollmentProvider>().setStudentNationality(value)),
                            const SizedBox(height: 40),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  RoundedBackArrowButton(
                                    onPressed: () {
                                      Navigator.push(context,MaterialPageRoute(builder: (context) => ParentContactDetails()));
                                    },
                                    size: 50,
                                  ),
                                  RoundedArrowButton(
                                    onPressed: () {
                                      _validateAndProceed(3);
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// **Reusable TextField**
  Widget buildTextField(String label, Function(String) onChanged, {bool? enabled, TextEditingController? controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF011839),
            ),
          ),
        ),
        const SizedBox(height: 5), // Small gap between label and TextField
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFF011839), width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFF011839), width: 2.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          ),
          enabled: enabled,
        ),
        //  const SizedBox(height: 15), // Space below TextField
      ],
    );
  }
}
