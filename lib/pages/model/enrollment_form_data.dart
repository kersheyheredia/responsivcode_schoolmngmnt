class EnrollmentFormData{
  //grade level& status
  String gradeLevel = '';
  String status ='';
  int userType = 0;

  //parent details
  String parentFirstName = '';
  String parentLastName = '';
  String parentMiddleName ='';
  bool isParentMiddleNameNA= false;
  String parentSuffix = '';
  bool isParentSuffixNA = false;
  int parentAge = 0;
  String parentGender = '';
  String parentDOB= '';
  String civilStatus = '';

  //Contact information
  int houseNumber=0;
  String street = '';
  String barangay = '';
  String city = '';
  int zipCode = 0;
  String cellphoneNumber = '';
  String landlineNumber = '';
  String parentEmail = '';

  //Student details
  String studentFirstName = '';
  String studentLastName = '';
  String studentMiddleName ='';
  String studentSuffix='';
  String month ='';
  String day='';
  String year='';
  String birthPlace = '';
  String studentAge='';
  String studentGender='';
  String religion = '';
  String studentCivilStatus = '';
  String nationality = '';

  //previous school information
  String schoolName = '';
  String dateAttended= '';
  String levelCompleted='';

  //documents

//validate fields
  bool areFieldsFilled(List<String> requiredFields){
    for (String field in requiredFields){
      var value = this._getFieldValue(field);
      print("Field: $field, Value: '$value'");
      if (value == null || value.toString().trim().isEmpty) {
        print("Validation failed for: $field");
        return false; // Return false if any required field is empty
      }
    }
    return true;
  }

  //helper function to get fields
  dynamic _getFieldValue(String fieldName){
    var mirror = this as dynamic;
    return mirror?.toJson()[fieldName];
  }

  Map<String, dynamic> toJson() {
    return {
      'gradeLevel': gradeLevel ?? '',
      'status': status ?? '',
      'parentFirstName': parentFirstName ?? '',
      'parentLastName': parentLastName ?? '',
      'parentMiddleName': parentMiddleName ?? '',
      'parentSuffix': parentSuffix ?? '',
      'parentAge': parentAge ?? '',
      'parentGender': parentGender ?? '',
      'parentDOB': parentDOB ?? '',
      'civilStatus': civilStatus ?? '',
      'houseNumber': houseNumber ?? '',
      'street': street ?? '',
      'barangay': barangay ?? '',
      'city': city ?? '',
      'zipCode': zipCode ?? '',
      'cellphoneNumber': cellphoneNumber ?? '',
      'landlineNumber': landlineNumber ?? '',
      'parentEmail': parentEmail ?? '',
      'studentFirstName': studentFirstName ?? '',
      'studentLastName': studentLastName ?? '',
      'studentMiddleName': studentMiddleName ?? '',
      'studentSuffix': studentSuffix ?? '',
      'month': month ?? '',
      'day': day ?? '',
      'year': year ?? '',
      'birthPlace': birthPlace ?? '',
      'studentAge': studentAge ?? '',
      'studentGender': studentGender ?? '',
      'religion': religion ?? '',
      'studentCivilStatus': studentCivilStatus ?? '',
      'nationality': nationality ?? '',
      'schoolName': schoolName ?? '',
      'dateAttended': dateAttended ?? '',
      'levelCompleted': levelCompleted ?? '',
    };
  }
}