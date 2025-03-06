import 'package:enrollment_system/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DateOfBirthPicker extends StatefulWidget {
  const DateOfBirthPicker({super.key});

  @override
  _DateOfBirthPickerState createState() => _DateOfBirthPickerState();
}

class _DateOfBirthPickerState extends State<DateOfBirthPicker> {
  String? selectedMonth;
  String? selectedDay;
  String? selectedYear;

  final List<String> months = [
    "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"
  ];
  final List<String> days = List.generate(31, (index) => (index + 1).toString().padLeft(2, '0'));
  final List<String> years = List.generate(100, (index) => (DateTime.now().year - index).toString());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Date of Birth",
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: AppColors.primaryColor
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// Month Dropdown
            Expanded(
              child: buildDropdown(
                hint: "mm",
                value: selectedMonth,
                items: months,
                onChanged: (value) {
                  setState(() {
                    selectedMonth = value;
                  });
                },
              ),
            ),
            const SizedBox(width: 10),

            /// Day Dropdown
            Expanded(
              child: buildDropdown(
                hint: "dd",
                value: selectedDay,
                items: days,
                onChanged: (value) {
                  setState(() {
                    selectedDay = value;
                  });
                },
              ),
            ),
            const SizedBox(width: 10),

            /// Year Dropdown
            Expanded(
              child: buildDropdown(
                hint: "yyyy",
                value: selectedYear,
                items: years,
                onChanged: (value) {
                  setState(() {
                    selectedYear = value;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Helper function to build a dropdown
  Widget buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primaryColor),
        ),
      ),
      value: value,
      hint: Text(hint, style: GoogleFonts.poppins(fontSize: 14, color: AppColors.primaryColor)),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item, style: GoogleFonts.poppins(fontSize: 14)),
        );
      }).toList(),
      onChanged: onChanged,
      icon: Icon(Icons.arrow_drop_down, color: AppColors.primaryColor ),
    );
  }
}