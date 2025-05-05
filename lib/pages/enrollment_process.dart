import 'package:enrollment_system/pages/assessment.dart';
import 'package:enrollment_system/pages/grade_level_selection.dart';
import 'package:enrollment_system/pages/model/enrollment_step.dart';
import 'package:enrollment_system/pages/service/api_service.dart';
import 'package:enrollment_system/pages/subject_selection.dart';
import 'package:enrollment_system/utils/colors.dart';
import 'package:enrollment_system/utils/custom_header.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EnrollmentProcess extends StatefulWidget {
  const EnrollmentProcess({super.key});

  @override
  State<EnrollmentProcess> createState() => _EnrollmentProcessState();
}

class _EnrollmentProcessState extends State<EnrollmentProcess> {
  final ApiService apiService = ApiService();
  late Future<List<EnrollmentStep>> _stepsFuture; // <--- correct future

  @override
  void initState() {
    super.initState();
    _stepsFuture = apiService
        .fetchEnrollmentSteps(); // <- pass your userId dynamically later
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: FutureBuilder<List<EnrollmentStep>>(
        future: _stepsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No steps found.'));
          }

          final steps = snapshot.data!;

          return Column(
            children: [
              CustomHeader(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Center(
                  child: Text(
                    "Enrollment Process",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          'Note: Please ensure that all required documents are uploaded and the enrollment process is fully completed to avoid any delays.',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: List.generate(steps.length, (index) {
                          final step = steps[index];
                          final stepNumber = step.stepNumber; // from API
                          final stepName = step.stepTemplateName; // from API
                          final stepStatus = step.status; // from API

                          Icon stepIcon;
                          Color stepColor;

                          if (stepStatus == 'approved') {
                            stepIcon =
                                Icon(Icons.check_circle, color: Colors.green);
                            stepColor = Colors.green.withOpacity(0.1);
                          } else if (stepStatus == 'Rejected') {
                            stepIcon = Icon(Icons.cancel, color: Colors.red);
                            stepColor = Colors.red.withOpacity(0.1);
                          } else {
                            stepIcon = Icon(Icons.radio_button_unchecked,
                                color: Colors.grey);
                            stepColor = Colors.grey.withOpacity(0.1);
                          }

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                  color: Colors.grey.withOpacity(0.2), // <-- slightly stronger border
                                  width: 1, // <-- a little thicker
                                ),
                              ),
                              elevation: 8,
                              shadowColor: Colors.grey.withOpacity(0.3),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: ListTile(
                                  tileColor: Colors.white,
                                  title: RichText(
                                    text: TextSpan(
                                      style: DefaultTextStyle.of(context).style,
                                      children: [
                                        TextSpan(
                                          text: 'Step $stepNumber. ',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14, // optional, match your sizing
                                            color: Colors.black, // make sure to set color
                                          ),
                                        ),
                                        TextSpan(
                                          text: stepName,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14, // same size
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  leading: stepIcon,
                                  trailing: (stepNumber == 1 || stepNumber == 6 || stepNumber == 4) 
                                      ? const Icon(Icons.arrow_forward_ios,
                                      size: 16, color: Colors.black)
                                      : null,
                                  onTap: (){
                                    if(stepNumber == 1) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => GradeLevelSelection())
                                      );
                                    }else if (stepNumber == 4){
                                      Navigator.push(
                                          context, 
                                          MaterialPageRoute(builder: (context) => SubjectSelection())
                                      );
                                    }else if (stepNumber == 6){
                                      Navigator.push(context, 
                                      MaterialPageRoute(builder: (context) => AssessmentScreen())
                                      );
                                    };
                                  },
                                ),
                              )
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey[300],
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: const Center(
                            child: Text(
                              'OFFICIALLY ENROLLED',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ))
            ],
          );
        },
      ),
    );
  }
}
