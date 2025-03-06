import 'package:enrollment_system/pages/grade_level_selection.dart';
import 'package:enrollment_system/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:enrollment_system/utils/top_design.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterParent extends StatefulWidget {
  const RegisterParent({super.key});

  @override
  State<RegisterParent> createState() => _RegisterParentState();
}

class _RegisterParentState extends State<RegisterParent> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TopDesign(),
          const SizedBox(height: 20),
          Image.asset(
            'lib/assets/images/logo.png',
            height: 150,
            width: 150,
          ),
         Expanded(
             child: SingleChildScrollView(
              child:Padding(
               padding: const EdgeInsets.symmetric(horizontal: 20 ),
               child: Column(
                 children: [
                   Text("Create an Account",
                     style:GoogleFonts.poppins(
                         color: AppColors.primaryColor,
                         fontWeight: FontWeight.bold,
                         fontSize: 30
                     ),
                   ),
                   SizedBox(height: 30),
                   buildTextField("First Name"),
                   SizedBox(height: 15),
                   Row(
                     children: [
                       Expanded(
                           flex: 2,
                           child: buildTextField("Last Name")),
                       SizedBox(width: 5),
                       Expanded(child: buildTextField("M.!")),
                     ],
                   ),
                   buildTextField("Email Address"),
                   SizedBox(height: 15),
                   buildTextField("Password"),
                   SizedBox(height: 15),
                   buildTextField("Phone Number"),
                   SizedBox(height: 20),
                   Text("Student Information",
                     style: GoogleFonts.poppins(
                         color: AppColors.primaryColor,
                         fontWeight: FontWeight.w500,
                         fontSize: 16
                     ),
                   ),
                   SizedBox(height: 15),
                   buildTextField("Student's Fullname"),
                   SizedBox(height: 15),
                   buildTextField("Student's ID No."),
                   SizedBox(height: 15),
                   SizedBox(
                     //width: double.infinity,
                     height: 50,
                     child: ElevatedButton(
                       style: ElevatedButton.styleFrom(
                         backgroundColor: AppColors.primaryColor,
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(10),
                         ),
                       ),
                       onPressed: () {
                         WidgetsBinding.instance.addPostFrameCallback((_) {
                           Navigator.push(
                             context,
                             MaterialPageRoute(builder: (context) => GradeLevelSelection()),
                           );
                         });
                       },
                       child: Text(
                         'Add another student',
                         style: GoogleFonts.poppins(
                           fontSize: 10,
                           color: Colors.white,
                         ),
                       ),
                     ),
                   ),
                   SizedBox(height: 15),
                   Row(
                     mainAxisSize: MainAxisSize.min, // Prevents extra spacing
                     children: [
                       Checkbox(
                         value: isChecked,
                         onChanged: (bool? value) {
                           setState(() {
                             isChecked = value ?? false;
                           });
                         },
                         activeColor: AppColors.primaryColor,
                         materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduce default padding
                         visualDensity: VisualDensity(horizontal: -4, vertical: -4),// Makes checkbox smaller and aligned
                       ),
                       const SizedBox(width: 5), // Reduce spacing between Checkbox and text
                       const Text(
                         'I have agreed to the terms and conditions',
                         style: TextStyle(
                           color: Color(0xFF011839),
                         ),
                       ),
                     ],
                   ),
                   SizedBox(height: 15),
                   SizedBox(
                     //width: double.infinity,
                     height: 50,
                     child: ElevatedButton(
                       style: ElevatedButton.styleFrom(
                         backgroundColor: AppColors.primaryColor,
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(10),
                         ),
                       ),
                       onPressed: () {
                         WidgetsBinding.instance.addPostFrameCallback((_) {
                           Navigator.push(
                             context,
                             MaterialPageRoute(builder: (context) => GradeLevelSelection()),
                           );
                         });
                       },
                       child: Text(
                         'Create Account',
                         style: GoogleFonts.poppins(
                           fontSize: 18,
                           color: Colors.white,
                         ),
                       ),
                     ),
                   ),
                   SizedBox(height: 20),
                 ],
               ),
             )
         ))
        ],
      ),
    );
  }
}
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
