import 'package:enrollment_system/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomDropdowns extends StatefulWidget {
  @override
  _CustomDropdownsState createState() => _CustomDropdownsState();
}

class _CustomDropdownsState extends State<CustomDropdowns> {
  String? selectedGrade;
  String? selectedStatus;

  List<String> gradeLevels = ['Grade 1', 'Grade 2', 'Grade 3'];
  List<String> statuses = ['Active', 'Inactive', 'Pending'];

  @override
  Widget build(BuildContext context) {
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
                    offset: Offset(0, 3), // ✅ Shadow only at the bottom
                  ),
                ],
              ),
              child: DropdownButtonFormField<String>(
                isExpanded: true, // ✅ Prevents overflow
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  border: InputBorder.none, // ✅ No default border
                ),
                value: selectedGrade,
                hint: Text('Select Grade Level', style: TextStyle(color: AppColors.primaryColor)),
                items: gradeLevels.map((String item) {
                  return DropdownMenuItem(value: item, child: Text(item));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedGrade = value;
                  });
                },
                icon: Icon(Icons.keyboard_arrow_down, color: AppColors.primaryColor),
              ),
            ),
          ),
          SizedBox(width: 8), // ✅ Adjust spacing to prevent overflow

          // Second Dropdown (Select Status) - Same Design as First
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 6,
                    offset: Offset(0, 3), // ✅ Shadow only at the bottom
                  ),
                ],
              ),
              child: DropdownButtonFormField<String>(
                isExpanded: true, // ✅ Prevents overflow
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  border: InputBorder.none, // ✅ No default border
                ),
                value: selectedStatus,
                hint: Text('Select Status', style: TextStyle(color: AppColors.primaryColor)),
                items: statuses.map((String item) {
                  return DropdownMenuItem(value: item, child: Text(item));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedStatus = value;
                  });
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
