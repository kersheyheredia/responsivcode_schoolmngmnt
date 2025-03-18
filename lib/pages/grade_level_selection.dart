import 'package:enrollment_system/pages/class/enrollment_provider.dart';
import 'package:enrollment_system/pages/parent_contact_details.dart';
import 'package:enrollment_system/utils/bottom_design.dart';
import 'package:enrollment_system/utils/colors.dart';
import 'package:enrollment_system/utils/custom_header.dart';
import 'package:enrollment_system/utils/step_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:enrollment_system/utils/dropdown.dart';
import 'package:enrollment_system/utils/forward_button.dart';
import 'package:provider/provider.dart';

class GradeLevelSelection extends StatefulWidget {
  const GradeLevelSelection({super.key});

  @override
  State<GradeLevelSelection> createState() => _GradeLevelSelectionState();
}

class _GradeLevelSelectionState extends State<GradeLevelSelection> {
  int currentStep = 1;

  String? selectedGradeLevel;
  String? selectedStatus;

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

  //validate method
  void _validateAndProceed() {
    final enrollmentProvider = Provider.of<EnrollmentProvider>(context, listen: false);

    if (enrollmentProvider.formData.gradeLevel.isEmpty || enrollmentProvider.formData.status.isEmpty) {
      // Show error message if either dropdown is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please select both Grade Level and Status."),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      // Proceed to next page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ParentContactDetails()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
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
              const SizedBox(height: 30),
              // Title
              Center(
                child: Text(
                  'Select Grade Level and Status',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 5),

              // Subtitle
              Center(
                child: Text(
                  'All fields are required.',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Dropdown Widget
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomDropdowns(),
              ),
              const Spacer(), // Pushes content upwards
              // Forward Button Positioned to the Right
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 100, right: 20),
                  child: RoundedArrowButton(
                    onPressed: () {
                      _validateAndProceed();
                    },
                    size: 45, // Ensures compact size
                  ),
                ),
              ),
              const SizedBox(height: 150), // Space for bottom design
            ],
          ),
          // Bottom Design (Fixed at the Bottom)
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomDesign(),
          ),
        ],
      ),
    );
  }
}
