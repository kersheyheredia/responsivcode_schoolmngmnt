import 'package:enrollment_system/pages/class/enrollment_provider.dart';
import 'package:enrollment_system/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDropdowns extends StatelessWidget {
  final List<String> gradeLevels = ['Grade 1', 'Grade 2', 'Grade 3'];
  final List<String> statuses = ['Old', 'New', 'Returnee', 'Transferee'];

  @override
  Widget build(BuildContext context) {
    final enrollmentProvider = Provider.of<EnrollmentProvider>(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          // First Dropdown (Select Grade)
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  border: InputBorder.none,
                ),
                value: enrollmentProvider.formData.gradeLevel.isNotEmpty
                    ? enrollmentProvider.formData.gradeLevel
                    : null,
                hint: Text('Select Grade Level', style: TextStyle(color: AppColors.primaryColor)),
                items: gradeLevels.map((String item) {
                  return DropdownMenuItem(value: item, child: Text(item));
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    enrollmentProvider.setGrade(value);
                  }
                },
                icon: Icon(Icons.keyboard_arrow_down, color: AppColors.primaryColor),
              ),
            ),
          ),
          SizedBox(width: 8),

          // Second Dropdown (Select Status)
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  border: InputBorder.none,
                ),
                value: enrollmentProvider.formData.status.isNotEmpty
                    ? enrollmentProvider.formData.status
                    : null,
                hint: Text('Select Status', style: TextStyle(color: AppColors.primaryColor)),
                items: statuses.map((String item) {
                  return DropdownMenuItem(value: item, child: Text(item));
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    enrollmentProvider.setStatus(value);
                  }
                },
                icon: Icon(Icons.keyboard_arrow_down, color: AppColors.primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
