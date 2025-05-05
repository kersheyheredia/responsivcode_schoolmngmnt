import 'dart:io';

import 'package:enrollment_system/pages/model/enrollment_form_data.dart';
import 'package:flutter/material.dart';

class EnrollmentProvider with ChangeNotifier {
  EnrollmentFormData _formData = EnrollmentFormData();

  EnrollmentFormData get formData => _formData;
  // Flags for "Not Applicable" checkboxes
  bool isParentMiddleNameNA = false;
  bool isParentSuffixNA = false;
  bool isStudentMiddleNameNA = false;
  bool isStudentSuffixNA = false;

  void updateFormData(EnrollmentFormData newData) {
    _formData = newData;
    notifyListeners();
  }
  //isResetPassword
  void setIsResetPassword(String reset){
    _formData.isResetPassword = reset;
    notifyListeners();
  }
  //reset number
  void setResetNumber(String resetNo){
    _formData.resetNum=resetNo;
    notifyListeners();
  }
  //otp
  void setOtp(String otp){
    _formData.otp = otp;
    notifyListeners();
  }
  //new password
  void setNewPassword(String newPass){
    _formData.newPassword = newPass;
    notifyListeners();
  }


  //parent number
  void setParentNumber(String parentNumber){
    _formData.parentNumber = parentNumber;
    notifyListeners();
  }
//setters
  void setUserType(String userType){
    _formData.userType = userType;
    notifyListeners();
  }
  void setGrade(String grade){
    _formData.gradeLevel = grade;
    notifyListeners();
  }
  //setter for status
  void setStatus(String status){
    _formData.status = status;
    notifyListeners();
  }
  //setter for parent details
  void setParentFirstName(firstName){
    _formData.parentFirstName = firstName;
    notifyListeners();
  }
  void setParentLastName(lastName){
    _formData.parentLastName = lastName;
    notifyListeners();
  }
  void setParentMiddleName(String middleName) {
    if (!isParentMiddleNameNA) {
      _formData.parentMiddleName = middleName;
    }
    notifyListeners();
  }

  // Toggle "Not Applicable" for Middle Name
  void toggleParentMiddleNameNA(bool value) {
    isParentMiddleNameNA = value;
    _formData.parentMiddleName = value ? "N/A" : ""; // Set to "N/A" if checked
    notifyListeners();
  }

  // Toggle "Not Applicable" for Suffix
  void toggleParentSuffixNA(bool value) {
    isParentSuffixNA = value;
    _formData.parentSuffix = value ? "N/A" : ""; // Set to "N/A" if checked
    notifyListeners();
  }

  void setParentSuffix(String suffix) {
    if (!isParentSuffixNA) {
      _formData.parentSuffix = suffix;
    }
    notifyListeners();
  }

  void setParentAge(int age){
    _formData.parentAge = age;
    notifyListeners();
  }

  void setParentGender(String gender){
    _formData.parentGender = gender;
    notifyListeners();
  }

  void setParentDOB(String DoB){
    _formData.parentDOB = DoB;
    notifyListeners();
  }

  void setParentCivilStat(String status){
    _formData.civilStatus = status;
    notifyListeners();
  }

  void setHouseNo(String houseNum){
    int? parsedValue = int.tryParse(houseNum); // Convert string to int safely
    if (parsedValue != null) {
      _formData.houseNumber = parsedValue;
      notifyListeners(); // Notify UI of changes
    }
  }

  void setStreet(String street){
    _formData.street = street;
    notifyListeners();
  }

  void setBarangay(String barangay) {
    _formData.barangay = barangay;
    notifyListeners();
  }

  void setCity(String city){
    _formData.city = city;
    notifyListeners();
  }

  void setZipCode(String zipCode){
    int? parsedvalue = int.tryParse(zipCode);
    if(parsedvalue != null){
      _formData.zipCode = parsedvalue;
      notifyListeners();
    }
  }

  void setCellNumber(String cellphoneNum){
    _formData.cellphoneNumber = cellphoneNum;
    notifyListeners();
  }

  void setLandline(String landline){
    _formData.landlineNumber = landline;
    notifyListeners();
  }

  void setEmail(String email){
    _formData.parentEmail = email;
    notifyListeners();
  }

  //students
  void setStudentFirstName(String firstName){
    _formData.studentFirstName = firstName;
    notifyListeners();
  }
  void setStudentLastName(String lastName){
    _formData.studentLastName = lastName;
    notifyListeners();
  }
  void setStudentMiddleName(String middleName) {
    if (!isStudentMiddleNameNA) {
      _formData.studentMiddleName = middleName;
    }
    notifyListeners();
  }
  // Toggle "Not Applicable" for Middle Name
  void toggleStudentMiddleName(bool value) {
    isStudentMiddleNameNA = value;
    _formData.studentMiddleName = value ? "N/A" : ""; // Set to "N/A" if checked
    notifyListeners();
  }

  // Toggle "Not Applicable" for Suffix
  void toggleStudentSuffix(bool value) {
    isStudentSuffixNA = value;
    _formData.studentSuffix = value ? "N/A" : ""; // Set to "N/A" if checked
    notifyListeners();
  }

  void setStudentSuffix(String suffix) {
    if (!isStudentSuffixNA) {
      _formData.studentSuffix = suffix;
    }
    notifyListeners();
  }
  void setStudentBMonth(String month){
    _formData.month = month;
    notifyListeners();
  }
  void setStudentBDay(String day){
    _formData.day = day;
    notifyListeners();
  }
  void setStudentBYear(String year){
    _formData.year = year;
    notifyListeners();
  }

  void setStudentDoB(String dob){
    _formData.studentDoB = dob;
    notifyListeners();
  }
  void setStudentBPlace(String birthPlace){
    _formData.birthPlace = birthPlace;
    notifyListeners();
  }
  void setStudentAge(String age){
    _formData.studentAge = age;
    notifyListeners();
  }
  void setStudentGender(String gender){
    _formData.studentGender = gender;
    notifyListeners();
  }
  void setStudentReligion(String religion){
    _formData.religion = religion;
    notifyListeners();
  }
  void setStudentStatus(String status){
    _formData.studentCivilStatus = status;
    notifyListeners();
  }
  void setStudentNationality(String nationality){
    _formData.nationality = nationality;
    notifyListeners();
  }
  //end of student details

  //academic information
  void setSchoolName(String schoolName){
    _formData.schoolName = schoolName;
    notifyListeners();
  }

  void setDatesAttended(String datesAttended){
    _formData.dateAttended = datesAttended;
    notifyListeners();
  }
  void setGradeCompleted(String gradeCompleted){
    _formData.levelCompleted = gradeCompleted;
    notifyListeners();
  }

  //uploaded documents
  void setFormFile(File file, String fileName){
    _formData.form138File = file;
    _formData.formFileName = fileName;
    notifyListeners();
  }
  void setPicFile(File file, String fileName){
    _formData.picFile = file;
    _formData.picFileName = fileName;
    notifyListeners();
  }

  //getters
  String get otp => _formData.otp;
  String get newPass => _formData.newPassword;
  String get resetNumber => _formData.resetNum;
  String get isResetPass => _formData.isResetPassword;
  String get parentNumber => _formData.parentNumber;
  String get gradeLevel => _formData.gradeLevel;
  String get status => _formData.status;
  String get userType => _formData.userType;
  String get parentFirstName => _formData.parentFirstName;
  String get parentLastName => _formData.parentLastName;
  String get parentMiddleName => _formData.parentMiddleName;
  String get parentSuffix => _formData.parentSuffix;
  int get parentAge => _formData.parentAge;
  String get parentGender => _formData.parentGender;
  String get parentDOB => _formData.parentDOB;
  String get civilStat => _formData.civilStatus;
  int get houseNo => _formData.houseNumber;
  String get street => _formData.street;
  String get barangay => _formData.barangay;
  String get city => _formData.city;
  int get zipCode =>_formData.zipCode;
  String get cellNo => _formData.cellphoneNumber;
  String get landlineNo => _formData.landlineNumber;
  String get email => _formData.parentEmail;

  //student data
  String get studentFirstName => _formData.studentFirstName;
  String get studentLastName => _formData.studentLastName;
  String get studentMiddleName => _formData.studentMiddleName;
  String get studentSuffix => _formData.studentSuffix;
  String get studentBMonth => _formData.month;
  String get studentBDay => _formData.day;
  String get studentBYear => _formData.year;
  String get studentDoB => _formData.studentDoB;
  String get studentBPlace=>_formData.birthPlace;
  String get studentAge => _formData.studentAge;
  String get studentGender => _formData.studentGender;
  String get studentReligion => _formData.religion;
  String get studentCivilStat => _formData.studentCivilStatus;
  String get studentNationality => _formData.nationality;

  //getters for academic information
  String get nameOfSchool => _formData.schoolName;
  String get dateAttended => _formData.dateAttended;
  String get gradeCompleted => _formData.levelCompleted;

  //getters for files
  File? get formFile => _formData.form138File;
  String? get fileName => _formData.formFileName;
  File? get picFile => _formData.picFile;
  String? get picFileName => _formData.picFileName;


  //field validate base on the step
  bool validate(int step){
    switch(step){
      case 1:
        return formData.areFieldsFilled([
          'gradeLevel',
          'status'
        ]);
      case 2:
        return formData.areFieldsFilled([
          // Parent Details
          'parentFirstName',
          'parentLastName',
          'parentMiddleName',
          'parentSuffix',
          'parentAge',
          'parentGender',
          'civilStatus',
          'houseNumber',
          'street',
          'barangay',
          'city',
          'zipCode',
          'cellphoneNumber',
          'landlineNumber',
          'parentEmail'
        ]);

      case 3:
        return  formData.areFieldsFilled([
          // Student Details
          'studentFirstName',
          'studentLastName',
          'studentMiddleName',
          'studentSuffix',
          'month',
          'day',
          'year',
          'birthPlace',
          'studentAge',
          'studentGender',
          'religion',
          'studentCivilStatus',
          'nationality'
        ]);

      case 4:
        return formData.areFieldsFilled([
          'schoolName',
          'dateAttended',
          'levelCompleted'
        ]);
      default:
        return false;
    }
  }
}
