class EnrollmentStep {
  final int id;
  final int stepNumber;
  final String status;
  final String stepTemplateName;

  EnrollmentStep({
    required this.id,
    required this.stepNumber,
    required this.status,
    required this.stepTemplateName,
  });

  factory EnrollmentStep.fromJson(Map<String, dynamic> json) {
    return EnrollmentStep(
      id: json['id'],
      stepNumber: json['stepTemplate']['stepNumber'],
      status: json['status'],
      stepTemplateName: json['stepTemplate']['name'],
    );
  }
}
