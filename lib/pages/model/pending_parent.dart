class PreAdmissionParent {
  final int id;
  final String parent_name;
  final String firstname;
  final String lastname;
  final String email_add;
  final String mobile_no;
  final String status;


  PreAdmissionParent({
    required this.id,
    required this.parent_name,
    required this.firstname,
    required this.lastname,
    required this.email_add,
    required this.mobile_no,
    required this.status,
  });

  factory PreAdmissionParent.fromJson(Map<String, dynamic> json) {
    return PreAdmissionParent(
      id: json['id'],
      parent_name: json['parent_name'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email_add: json['email_add'],
      mobile_no: json['mobile_no'],
      status: json['status'],
    );
  }
}
