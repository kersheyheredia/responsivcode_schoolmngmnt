import 'package:enrollment_system/pages/service/api_service.dart';
import 'package:flutter/material.dart';

class HeaderInfo extends StatefulWidget {


  const HeaderInfo({
    super.key
  });




  @override
  State<HeaderInfo> createState() => _HeaderInfoState();
}

class _HeaderInfoState extends State<HeaderInfo> {
  String? studentName;
  String? schoolYear;
  String? status;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    loadStudentData(); // Fetch student data on widget init
  }

  Future<void> loadStudentData() async {
    final profile = await apiService.fetchStudentDetails();
    if (profile != null) {
      setState(() {
        studentName = profile['student_name'];
        schoolYear = profile['schoolYear'];
        status = profile['status'];

      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Name: $studentName"),
              Spacer(),
              Text("Status: ", style: TextStyle(fontWeight: FontWeight.bold)),
              Text('$status', style: TextStyle(color: Colors.red)),
              const SizedBox(height: 8),
            ],
          ),
          Row(
            children: [
              Text("Select Grade Level: "),
              SizedBox(width: 10),
              DropdownButton<String>(
                value: "Grade 7",
                items: ["Grade 7", "Grade 8", "Grade 9"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (_) {},
              ),
              const Spacer(),
              Text("S.Y $schoolYear",
                  style: TextStyle(fontWeight: FontWeight.bold)
              ),
            ],
          ),
        ],
      ),
    );
  }
}
