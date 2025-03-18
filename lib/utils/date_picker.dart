import 'package:flutter/material.dart';

class DatePickerDropdown extends StatefulWidget {
  final Function(String, String, String) onDateSelected; // Callback function

  const DatePickerDropdown({Key? key, required this.onDateSelected}) : super(key: key);

  @override
  _DatePickerDropdownState createState() => _DatePickerDropdownState();
}

class _DatePickerDropdownState extends State<DatePickerDropdown> {
  String? selectedMonth;
  String? selectedDay;
  String? selectedYear;

  List<String> months = ["mm", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"];
  List<String> days = ["dd"];
  List<String> years = ["yyyy", ...List.generate(125, (index) => (2025 - index).toString())];

  @override
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
        const Text(
          "Date of Birth",
          style: TextStyle(fontSize: 16, color: Color(0xFF011839)),
        ),
        const SizedBox(height: 5),
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF011839), width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              DropdownButton<String>(
                value: selectedMonth,
                items: months.map((value) => DropdownMenuItem(value: value, child: Text(value))).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedMonth = newValue;
                    updateDays();
                    onDateChanged();
                  });
                },
                underline: Container(),
                iconEnabledColor: const Color(0xFF011839),
              ),
              const Text(" / "),
              DropdownButton<String>(
                value: selectedDay,
                items: days.map((value) => DropdownMenuItem(value: value, child: Text(value))).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedDay = newValue;
                    onDateChanged();
                  });
                },
                underline: Container(),
                iconEnabledColor: const Color(0xFF011839),
              ),
              const Text(" / "),
              DropdownButton<String>(
                value: selectedYear,
                items: years.map((value) => DropdownMenuItem(value: value, child: Text(value))).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedYear = newValue;
                    // updateDays();
                    onDateChanged();
                  });
                },
                underline: Container(),
                iconEnabledColor: const Color(0xFF011839),
              ),

            ],
          ),
        ),
      ],
    );
  }
}
