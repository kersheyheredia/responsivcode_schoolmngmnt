import 'package:enrollment_system/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DateOfBirthPicker extends StatefulWidget {
  final Function(String, String, String) onDateSelected;
  const DateOfBirthPicker({Key? key, required this.onDateSelected}) : super(key: key);

  @override
  _DateOfBirthPickerState createState() => _DateOfBirthPickerState();
}

class _DateOfBirthPickerState extends State<DateOfBirthPicker> {
  String? selectedMonth;
  String? selectedDay;
  String? selectedYear;

  List<String> months = ["mm", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"];
  List<String> days = ["dd"];
  List<String> years = ["yyyy", ...List.generate(125, (index) => (2025 - index).toString())];

  void initState() {
    super.initState();
    selectedMonth = months[0];
    selectedDay = days[0];
    selectedYear = years[0];
  }

  void updateDays() {
    if (selectedMonth == "mm") {
      setState(() => days = ["dd"]);
      return;
    }

    int month = int.parse(selectedMonth!);
    int maxDays = 31;

    if ([4, 6, 9, 11].contains(month)) {
      maxDays = 30;
    } else if (month == 2) {
      if (selectedYear != "yyyy") {
        int year = int.parse(selectedYear!);
        maxDays = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)) ? 29 : 28;
      } else {
        maxDays = 28; // No leap year check if year is not selected
      }
    }

    setState(() {
      days = ["dd", ...List.generate(maxDays, (i) => (i + 1).toString().padLeft(2, '0'))];
      if (!days.contains(selectedDay)) {
        selectedDay = "dd";
      }
    });
  }

  void onDateChanged() {
    if (selectedMonth != "mm" && selectedDay != "dd" && selectedYear != "yyyy") {
      widget.onDateSelected(selectedMonth!, selectedDay!, selectedYear!);
    }
  }


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
                    updateDays();
                    onDateChanged();
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
                    updateDays();
                    onDateChanged();
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
                    updateDays();
                    onDateChanged();
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