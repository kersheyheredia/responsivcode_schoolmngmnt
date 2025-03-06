import 'package:enrollment_system/pages/grade_level_selection.dart';
import 'package:enrollment_system/pages/login.dart';
import 'package:enrollment_system/pages/personal_details.dart';
import 'package:enrollment_system/utils/backward_button.dart';
import 'package:enrollment_system/utils/custom_header.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:enrollment_system/utils/colors.dart';
import 'package:enrollment_system/utils/forward_button.dart';
import 'package:enrollment_system/utils/bottom_design.dart';
import 'package:enrollment_system/utils/step_progress_indicator.dart';

class ParentContactDetails extends StatefulWidget {
  const ParentContactDetails({super.key});

  @override
  State<ParentContactDetails> createState() => _ParentContactDetailsState();
}

class _ParentContactDetailsState extends State<ParentContactDetails> {
  bool isMiddleNameNA = false;
  bool isSuffixNA = false;
  int currentStep = 2;

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
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      /// Background Image (Part of Scrollable Content)
                      Column(
                        children: [
                          SizedBox(height: 920), // Adjust height to position the image
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
                              "Parent/Guardian Details",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            const SizedBox(height: 15),
                            buildTextField("First Name"),
                            const SizedBox(height: 15),
                            buildTextField("Last Name"),
                            const SizedBox(height: 15),

                            /// Middle Name & Suffix
                            Row(
                              children: [
                                Expanded(flex: 2, child: buildTextField("Middle Name")),
                                const SizedBox(width: 10),
                                Expanded(child: buildTextField("Suffix")),
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
                                    });
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
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(width: 128),
                                Checkbox(
                                  value: isSuffixNA,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isSuffixNA = value ?? false;
                                    });
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
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(child: buildTextField("Age")),
                                const SizedBox(width: 10),
                                Expanded(flex: 2, child: buildTextField("Gender")),
                              ],
                            ),
                            const SizedBox(height: 15),

                            /// **Date of Birth & Civil Status**
                            Row(
                              children: [
                                Expanded(flex: 2, child: buildDropdownField("Date of Birth")),
                                const SizedBox(width: 10),
                                Expanded(child: buildTextField("Civil Status")),
                              ],
                            ),
                            const SizedBox(height: 40),
                            Text(
                              "Contact Information",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                                "Current Address",
                              style: GoogleFonts.poppins(
                                color: AppColors.primaryColor,
                                fontSize: 16
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(child: buildTextField("House #")),
                                const SizedBox(width: 10),
                                Expanded(flex: 2, child: buildTextField("Street")),
                              ],
                            ),

                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(flex: 2, child: buildTextField("Barangay")),
                                const SizedBox(width: 10),
                                Expanded(child: buildTextField("City")),
                                const SizedBox(width: 10),
                                Expanded(child: buildTextField("Zip Code")),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(child: buildTextField("Cellphone #")),
                                const SizedBox(width: 10),
                                Expanded( child: buildTextField("Landline #")),
                              ],
                            ),

                            const SizedBox(height: 15),
                            buildTextField("Email"),
                            const SizedBox(height: 40),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  RoundedBackArrowButton(
                                    onPressed: () {
                                    Navigator.push(context,MaterialPageRoute(builder: (context) => GradeLevelSelection()));
                                    },
                                    size: 50,
                                  ),
                                  RoundedArrowButton(
                                    onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalDetails()));
                                    },
                                    size: 50,
                                  ),
                                ]
                            ),
                            //const SizedBox(height: 50),// Extra padding for better spacing
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
  Widget buildTextField(String label) {
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
        ),
        //  const SizedBox(height: 15), // Space below TextField
      ],
    );
  }
  /// **Reusable Dropdown Field (For Date of Birth)**
  Widget buildDropdownField(String label) {
    return Column(
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
        const SizedBox(height: 5),
        SizedBox(
          width: double.infinity,
          child: Container(
            height: 50, // Set a fixed height
            padding: const EdgeInsets.symmetric(horizontal: 10),
            // Adjust padding
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryColor, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min, // Prevent extra space
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<String>(
                  value: "mm",
                  items: ["mm", "01", "02", "03", "04", "05"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: GoogleFonts.poppins(
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {},
                  underline: Container(), // Remove default underline
                  iconEnabledColor: const Color(0xFF011839),
                ),
                Text(" / ",
                  style: GoogleFonts.poppins(
                    color: AppColors.primaryColor,
                  ),
                ),
                DropdownButton<String>(
                  value: "dd",
                  items: ["dd", "01", "02", "03", "04", "05"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: GoogleFonts.poppins(
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {},
                  underline: Container(),
                  iconEnabledColor: AppColors.primaryColor,
                ),
                const Text(" / "),
                DropdownButton<String>(
                  value: "yyyy",
                  items: ["yyyy", "2000", "2001", "2002", "2003"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: GoogleFonts.poppins(
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {},
                  underline: Container(),
                  iconEnabledColor: AppColors.primaryColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
