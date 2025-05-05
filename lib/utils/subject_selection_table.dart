import 'package:enrollment_system/utils/custom_expandable_section.dart';
import 'package:flutter/material.dart';
import 'package:enrollment_system/pages/model/subject_select.dart';
import 'package:enrollment_system/utils/colors.dart';

class SubjectSelectionTable extends StatefulWidget {
  final Map<String, List<SubjectSelect>> sectionSubjects;

  const SubjectSelectionTable({required this.sectionSubjects, super.key});

  @override
  State<SubjectSelectionTable> createState() => _SubjectSelectionTableState();
}

class _SubjectSelectionTableState extends State<SubjectSelectionTable> {
  final Map<String, bool> _selectedSections = {};

  @override
  void initState() {
    super.initState();
    widget.sectionSubjects.keys.forEach((section) {
      _selectedSections[section] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildTableHeader(),
          ...widget.sectionSubjects.entries.map((entry) {
            return CustomExpandableSection(
              sectionName: entry.key,
              subjects: entry.value,
              isSelected: _selectedSections[entry.key] ?? false,
              onCheckboxChanged: (value) {
                setState(() {
                  _selectedSections[entry.key] = value;
                });
              },
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      color: AppColors.primaryColor,
      padding: const EdgeInsets.all(12),
      child: Row(
        children: const [
          Expanded(child: Text("Section", style: TextStyle(color: Colors.white, fontSize: 12))),
          Expanded(child: Text("Subjects", style: TextStyle(color: Colors.white, fontSize: 12))),
          Expanded(child: Text("Room", style: TextStyle(color: Colors.white, fontSize: 12))),
          Expanded(child: Text("Days", style: TextStyle(color: Colors.white, fontSize: 12))),
          SizedBox(width: 20), // arrow space
          Expanded(child: Text("Time", style: TextStyle(color: Colors.white, fontSize: 12))),
          SizedBox(width: 30), // checkbox space
        ],
      ),
    );
  }
}
