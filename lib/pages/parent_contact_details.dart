import 'package:enrollment_system/pages/class/enrollment_provider.dart';
import 'package:enrollment_system/pages/grade_level_selection.dart';
import 'package:enrollment_system/pages/login.dart';
import 'package:enrollment_system/pages/personal_details.dart';
import 'package:enrollment_system/utils/backward_button.dart';
import 'package:enrollment_system/utils/custom_header.dart';
import 'package:enrollment_system/utils/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:enrollment_system/utils/colors.dart';
import 'package:enrollment_system/utils/forward_button.dart';
import 'package:enrollment_system/utils/bottom_design.dart';
import 'package:enrollment_system/utils/step_progress_indicator.dart';
import 'package:provider/provider.dart';

class ParentContactDetails extends StatefulWidget {
  const ParentContactDetails({super.key});



  @override
  State<ParentContactDetails> createState() => _ParentContactDetailsState();
}

class _ParentContactDetailsState extends State<ParentContactDetails> {

  int currentStep = 2;
  bool isMiddleNameNA = false;
  bool isSuffixNA = false;
  TextEditingController middleNameController = TextEditingController();
  TextEditingController suffixController = TextEditingController();

  //for DOB
  String selectedDate = "";

  // void handleDateSelected(String month, String day, String year) {
  //   setState(() {
  //     context.read<EnrollmentProvider>().setParentDOB("$month/$day/$year");
  //   });
  // }

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
      Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalDetails()));
    }
  }
  @override
  void dispose(){
    middleNameController.dispose();
    suffixController.dispose();
  }

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
                            buildTextField("First Name",(value) => context.read<EnrollmentProvider>().setParentFirstName(value)),
                            const SizedBox(height: 15),
                            buildTextField("Last Name", (value) => context.read<EnrollmentProvider>().setParentLastName(value)),
                            const SizedBox(height: 15),

                            /// Middle Name & Suffix
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: buildTextField("Middle Name",
                                          controller: middleNameController,
                                          (value) => context.read<EnrollmentProvider>().setParentMiddleName(value),
                                          enabled: !isMiddleNameNA,)),

                                const SizedBox(width: 10),
                                Expanded(child: buildTextField("Suffix",
                                        controller: suffixController,
                                        (value) => context.read<EnrollmentProvider>().setParentSuffix(value),
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
                                    context.read<EnrollmentProvider>().toggleParentMiddleNameNA(isMiddleNameNA);
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
                                    context.read<EnrollmentProvider>().toggleParentSuffixNA(isSuffixNA);
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
                            Row(
                              children: [
                                Expanded(child: buildTextField("Age",
                                        (value) => context.read<EnrollmentProvider>().setParentAge(value as int))),
                                const SizedBox(width: 10),
                                Expanded(flex: 2, child: buildTextField("Gender", (value) => context.read<EnrollmentProvider>().setParentGender(value))),
                              ],
                            ),
                            const SizedBox(height: 15),

                            /// **Date of Birth & Civil Status**
                            Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    // child: buildDropdownField("Date of Birth")
                                    child:  DatePickerDropdown(
                                      onDateSelected: (month, day, year) {
                                        context.read<EnrollmentProvider>().setParentDOB("$month/$day/$year");
                                      },
                                    ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                    child: buildTextField("Civil Status", (value) => context.read<EnrollmentProvider>().setParentCivilStat(value)
                                    )),
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
                                Expanded(child: buildTextField("House #", (value) => context.read<EnrollmentProvider>().setHouseNo(value))),
                                const SizedBox(width: 10),
                                Expanded(flex: 2, child: buildTextField("Street", (value) => context.read<EnrollmentProvider>().setStreet(value))),
                              ],
                            ),

                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(flex: 2, child: buildTextField("Barangay", (value) => context.read<EnrollmentProvider>().setBarangay(value))),
                                const SizedBox(width: 10),
                                Expanded(child: buildTextField("City", (value) => context.read<EnrollmentProvider>().setCity(value))),
                                const SizedBox(width: 10),
                                Expanded(child: buildTextField("Zip Code", (value) => context.read<EnrollmentProvider>().setZipCode(value
                                ))),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(child: buildTextField("Cellphone #", (value) => context.read<EnrollmentProvider>().setCellNumber(value))),
                                const SizedBox(width: 10),
                                Expanded( child: buildTextField("Landline #", (value) => context.read<EnrollmentProvider>().setLandline(value))),
                              ],
                            ),

                            const SizedBox(height: 15),
                            buildTextField("Email", (value) => context.read<EnrollmentProvider>().setEmail(value)),
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
                                      _validateAndProceed(2);
                                      // Navigator.push(context,MaterialPageRoute(builder: (context) => PersonalDetails()));
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
      ],
    );
  }
}
