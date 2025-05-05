import 'package:enrollment_system/pages/model/subject_select.dart';

class Section {
  final String name;
  final List<SubjectSelect> subjects;

  Section({
    required this.name,
    required this.subjects,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    var subjectList = (json['subjects'] as List)
        .map((s) => SubjectSelect.fromJson(s))
        .toList();

    return Section(
      name: json['name'],
      subjects: subjectList,
    );
  }
}