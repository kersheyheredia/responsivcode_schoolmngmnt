import 'package:enrollment_system/pages/model/subject_select.dart';

class SubjectSelect {
  final int subjectId;
  final String code;
  final String room;
  final String days;
  final String time;

  SubjectSelect({
    required this.subjectId,
    required this.code,
    required this.room,
    required this.days,
    required this.time,
  });

  factory SubjectSelect.fromJson(Map<String, dynamic> json) {
    return SubjectSelect(
      subjectId: json['subject_id'] ,
      code: json['subject_code'] ,
      room: json['room'] ,
      days: json['days'] ,
      time: json['time'],
    );
  }
}
