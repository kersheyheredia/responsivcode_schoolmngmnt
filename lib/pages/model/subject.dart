import 'package:flutter/material.dart';

class Subject{
  final String title;
  final double percent;
  final Color color;
  final String note;

  Subject({
    required this.title,
    required this.percent,
    required this.color,
    required this.note,
  });

  factory Subject.fromMap(Map<String, dynamic> map) {
    return Subject(
      title: map['title'],
      percent: map['percent'],
      color: map['percent'] >= 0.75 ? Colors.green : Colors.red,
      note: map['note'],
    );
  }
}