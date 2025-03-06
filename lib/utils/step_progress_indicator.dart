import 'package:enrollment_system/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomStepper extends StatelessWidget {
  final int currentStep;

  const CustomStepper({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    List<String> titlesAbove = [
      'Grade Level Selection',
      '',
      'Student Details',
      '',
      'Document Uploads'
    ];

    List<String> titlesBelow = [
      '',
      'Parent and Contact Details',
      '',
      'Previous School Details',
      ''
    ];

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Titles Above Steps
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(titlesAbove.length, (index) {
              return SizedBox(
                width: 80, // Keep text aligned properly
                child: Text(
                  titlesAbove[index],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 8,
                    color: AppColors.primaryColor,
                  ),
                ),
              );
            }),
          ),

          // Stepper with Circles and Connecting Lines
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return Row(
                children: [
                  stepCircle(index + 1, isActive: index + 1 == currentStep), // Step circles
                  if (index < 4)
                    stepLine(index, isActive: index < currentStep), // Connecting lines except after the last step
                ],
              );
            }),
          ),

          // Titles Below Steps
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(titlesBelow.length, (index) {
              return SizedBox(
                width: 80,
                child: Text(
                  titlesBelow[index],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 8,
                    color: AppColors.primaryColor,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget stepLine(int step, {bool isActive = false}) {
    return Container(
      width: 60,
      height: 4,
      color: (currentStep > step + 1)  // If the next step is active, change color
          ? AppColors.primaryColor  // Active color
          : AppColors.secondaryColor.withAlpha(75), // Inactive color
    ); // Keep original color
  }
  Widget stepCircle(int step, {bool isActive = false}) {
    bool isCompleted = step < currentStep;
    return Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive || isCompleted ? AppColors.primaryColor : AppColors.secondaryColor.withAlpha(75),
      ),
      child: Center(
        child: Text(
          '$step',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}
