import 'dart:convert';
import 'package:enrollment_system/pages/class/enrollment_provider.dart';
import 'package:enrollment_system/pages/model/enrollment_step.dart';
import 'package:enrollment_system/pages/model/pending_parent.dart';
import 'package:enrollment_system/pages/model/section.dart';
import 'package:enrollment_system/pages/model/subject_select.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ApiService {
  static const String baseUrl = "http://10.0.2.2:8000";

  //@get
  Future<void> fetchData() async {
    final response = await http.get(
        Uri.parse("$baseUrl/api/auth/login/parent"));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("Response: $data");
    } else {
      print("Error: ${response.statusCode}");
    }
  }

//@login
  Future<bool> postData(String username, String password) async {
    final url = Uri.parse("$baseUrl/api/auth/login/parent");
    print("Sending API Request to: $url");
    print("Request Payload: ${jsonEncode({
      "username": username,
      "password": password
    })}");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "Application/json"},
        body: jsonEncode({
          "username": username,
          "password": password
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseData = jsonDecode(response.body);

        // ✅ Extract and save the token and parent number
        String? parentNum = responseData['parent_number']?.toString();
        String? token = responseData['token'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', token!);

        if (parentNum != null && token != null) {
          print("Saved Parent Number: $parentNum");
          print("Saved Token: $token");
        }

        return true;
      } else {
        print("Post error: ${response.statusCode} - ${response.body}");
        return false;
      }
    } catch (e) {
      print("Post exception: $e");
      return false;
    }
  }

  //register rpe-admission parent
  Future<bool> registerParent(
      String parentName,
      String pFirstName,
      String pLastName,
      String parentAddress,
      String mobile_no,
      String email_add,
      String studentName
      ) async {
    final url = Uri.parse("$baseUrl/api/pre-admission-parent-details");
    print("Sending API Request to: $url");
    print("Request Payload: ${jsonEncode({
      "parent":{
        "parent_name": parentName,
        "firstname": pFirstName,
        "lastname": pLastName,
        "parent_address": parentAddress,
        "mobile_no": mobile_no,
        "email_add": email_add,
      },
      "student":{
        "student_name":studentName
      }
    })}");
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "parent":{
            "parent_name": parentName,
            "firstname": pFirstName,
            "lastname": pLastName,
            "parent_address": parentAddress,
            "mobile_no": mobile_no,
            "email_add": email_add,
          },
          "student":{
            "student_name":studentName
          }
        }),
      );
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 201 || response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        int parentId = responseData['parentId'];
        print("Register success: $responseData");
        return true;
      } else {
        print("Post error: ${response.statusCode} - ${response.body}");
        return false;
      }
    } catch (e) {
      print("Post exception: $e");
    }
    return false;
  }

  //register pre-admission student
  Future<int?> registerStudent(String parentId,
      String studentName) async {
    int? final_parentId = int.tryParse(parentId);
    if (final_parentId == null) {
      return null; // Exit the function if userType is not a valid number
    }
    final url = Uri.parse('$baseUrl/api/student-details-pre-admission');
    print("Sending API Request to: $url");
    print("Request Payload: ${jsonEncode({
      "parentId": final_parentId,
      "student_name": studentName,

    })}");
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "parentId": final_parentId,
          "student_name": studentName,
        }),
      );
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 201 || response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print("Register success: $responseData");
        return null;
      } else {
        print("Post error: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      print("Post exception: $e");
    }
    return null;
  }

  //create person
  Future<int?> createPerson(String userType,
      String firstName,
      String lastName,
      String displayName,) async {
    int? userTypeInt = int.tryParse(userType);
    if (userTypeInt == null) {
      print("Invalid userType: $userType");
      return null; // Exit the function if userType is not a valid number
    }
    final url = Uri.parse("$baseUrl/api/person");
    print("Sending API Request to: $url");
    print("Request Payload: ${jsonEncode({
      "person_type_id": userTypeInt,
      "first_name": firstName,
      "last_name": lastName,
      "display_name": displayName,
    })}");
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "person_type_id": userTypeInt,
          "first_name": firstName,
          "last_name": lastName,
          "display_name": displayName,
        }),
      );
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 201 || response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print("Register success: $responseData");
        return responseData['person_id'];
      } else {
        print("Post error: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      print("Post exception: $e");
    }
    return null;
  }

  //create user
  Future<bool?> createUser(String personId,
      String userName,
      String password,
      String firstName,
      String lastName,
      String userType) async {
    final url = Uri.parse('$baseUrl/api/users');
    print("Sending API Request to: $url");
    print("Request payload: ${jsonEncode({
      "person_id": personId,
      "username": userName,
      "password": password,
      "first_name": firstName,
      "last_name": lastName,
      "Type_User": userType
    })}");

    try {
      final response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "person_id": personId,
            "username": userName,
            "password": password,
            "first_name": firstName,
            "last_name": lastName,
            "Type_User": userType
          })
      );
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 201 || response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print("User save: $responseData");
        return true;
      } else {
        print("Post error: ${response.statusCode} - ${response.body}");
        return true;
      }
    }
    catch (e) {
      print("Post exception: $e");
    }
    return false;
  }

  //reset password
  Future<Map<String, dynamic>?> resetPassword(String parentNumber,
      String mobileNumber,
      String isResetPassword) async {
    int? isReset = int.tryParse(isResetPassword);
    if (isReset == null) {
      print("Invalid: $isReset");
      return null; // Exit the function if userType is not a valid number
    }
    final url = Uri.parse("$baseUrl/api/auth/request-otp/parent");
    print("Sending API Request to: $url");
    print("Request Payload: ${jsonEncode({
      "parent_number": parentNumber,
      "mobile_no": mobileNumber,
      "isResetPassword": isReset
    })}");
    try {
      final response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "parent_number": parentNumber,
            "mobile_no": mobileNumber,
            "isResetPassword": isReset
          })
      );
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 201 || response.statusCode == 200) {
        var responseData = jsonDecode(response.body);

        // Return the response data to use it on the next page
        print("OTP Generated Successfully: $responseData");
        return responseData;
      } else {
        print("Post error: ${response.statusCode} - ${response.body}");
        return {
          "error": true,
          "message": "Failed to send OTP: ${response.statusCode}"
        };
      }
    } catch (e) {
      print("Post exception: $e");
    }
    return null;
  }

  //verify otp
  Future<bool> verifyOtpResetPass(String parentNumber,
      String userOtp, String
      newPass) async {
    final url = Uri.parse("$baseUrl/api/auth/reset-password/parent");

    print("Sending API Request to: $url");
    print("Request Payload: ${jsonEncode({
      "parent_number": parentNumber,
      "otp": userOtp, // ✅ Include the entered OTP
      "new_password": newPass
    })}");

    try {
      final response = await http.post(
        url,
        body: jsonEncode({
          'parent_number': parentNumber,
          'otp': userOtp, // ✅ Include user's OTP
          "new_password": newPass
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200 ||
          response.body.contains("Password reset successfully")) {
        print("OTP verified successfully.");
        return true; // ✅ OTP is valid
      } else {
        print("Failed to verify OTP.");
        print("Response Body: ${response.body}");
        return false; // ❌ Invalid OTP
      }
    } catch (e) {
      print('Exception: $e');
      return false;
    }
  }

  //subjects
  Future<void> fetchSubjects() async {
    // Simulate a network/API call delay
    await Future.delayed(Duration(seconds: 2));

    // Example of dynamic data (could come from Firebase, REST API, etc.)
    List<Map<String, dynamic>> subjectData = [
      {'title': 'Subject 1', 'percent': 0.89, 'note': 'no upcoming activities'},
      {
        'title': 'Subject 2',
        'percent': 0.95,
        'note': 'Math - Watch Fundamentals of Algebra'
      },
      {'title': 'Subject 3', 'percent': 0.42, 'note': 'no upcoming activities'},
      {'title': 'Subject 4', 'percent': 0.92, 'note': 'no upcoming activities'},
    ];

    // setState(() {
    //   subjects = subjectData.map((data) => Subject.fromMap(data)).toList();
    //   isLoading = false;
    // });
  }


  //get profile details

  //get the token from sharedpref
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    print('Retrieved Token: $token');
    return token;
  }

  //decode the token, get the id
  Future <int?> getUserIdFromToken() async {
    final token = await getToken();
    if (token == null) return null;

    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    print('decoded token: $decodedToken');
    return decodedToken ['userId'];
  }

  Future<Map<String, dynamic>?> fetchUserData() async {
    final token = await getToken();
    final userId = await getUserIdFromToken();
    final url = Uri.parse("$baseUrl/api/users/$userId");
    print('User id: $userId');

    if (token == null || userId == null) {
      print("Token or UserId is null.");
      return null;
    }
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-type': 'application/json',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Response status: ${response.statusCode}");
        print("Response body: ${response.body}");
        return jsonDecode(response.body);
      } else {
        print('Error fetching user profile: ${response.statusCode}');
      }
    } catch (e) {
      print("Exception: $e");
    }

    return null;
  }

  //get all pending parents
  Future <List<PreAdmissionParent>> fetchPreAdmissionParent() async {
    final url = Uri.parse("$baseUrl/api/pre-admission-parent-details");

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((e) => PreAdmissionParent.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load pre-admission list');
    }
  }

  //send parent default login credentials
  Future<void> sendParentCredentials(String email, String parentNumber) async {
    final url = Uri.parse(
        "$baseUrl/api/parent-credentials/send-parent-credentials");

    print("Sending API Request to: $url");
    print("Request Payload: ${jsonEncode({
      'email': email,
      'parentNumber': parentNumber,
      'password': parentNumber
    })}");
    final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'parentNumber': parentNumber,
          'password': parentNumber
        })
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
    } else {
      throw Exception('Failed to send email: ${response.body}');
    }
  }

  //transfer data to parent table
  Future<void> saveParent(int id, int personId) async {
    final parentId = id;
    final url = Uri.parse("$baseUrl/api/parent-credentials/$parentId/accept");

    print("Sending API Request to: $url");
    print("Request payload: ${jsonEncode({
      'id': id,
      'personId': personId
    })}");

    final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'id': id,
          'personId': personId
        })
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      final responseData = jsonDecode(response.body);

      final userId = responseData['userId'];
      print('User ID from acceptParent: $userId');

      if (userId == null) {
        throw Exception('No userId returned from server');
      }

      // 2. Now initialize the enrollment steps using the new userId
      await initEnrollmentSteps(userId);
    } else {
      throw Exception('Failed saving to parent table: ${response.body}');
    }
  }

  //initial steps
  Future<void> initEnrollmentSteps(int userId) async {
    try {
      print('Initializing enrollment steps for user ID: $userId');

      // Make the API request to initialize steps
      final response = await http.post(
        Uri.parse('$baseUrl/api/enrollment-steps/init/$userId'),
        headers: {
          'Content-Type': 'application/json', // No Authorization header needed
        },
      );

      print('API Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode != 201 && response.statusCode != 200) {
        print('Failed to initialize enrollment steps. Response body: ${response.body}');
        throw Exception('Failed to initialize enrollment steps');
      }

      print('Enrollment steps initialized successfully');
    } catch (e) {
      print('Error occurred during enrollment step initialization: $e');
      rethrow;
    }
  }

  //fetch steps
  Future<List<EnrollmentStep>> fetchEnrollmentSteps() async {
    final userId = await getUserIdFromToken();
    final token = await getToken();
    final url = Uri.parse('$baseUrl/api/enrollment-steps/steps');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((step) => EnrollmentStep.fromJson(step)).toList();
      } else {
        throw Exception('Failed to load enrollment steps');
      }
  }

  //fetch student data
  Future<Map<String, dynamic>?> fetchStudentDetails() async{
    final token = await getToken();
    final userId = await getUserIdFromToken();
    final url = Uri.parse('$baseUrl/api/student-details-pre-admission/student-info');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Student info: $data');
      if (data.isNotEmpty) {
        return data[0]; // return the first student object
      }
      // You can now use this data in your app (e.g., update state)
    } else {
      print('Failed to fetch student info: ${response.statusCode}');
      print(response.body);
    }
    return null;
  }

  //fetch subjects for selection
  Future<Map<String, List<SubjectSelect>>>  fetchSections() async {
    final token = await getToken();
    final url = Uri.parse('$baseUrl/api/subject-selection/section-subjects');

    print('[DEBUG] Fetching sections from: $url');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('[DEBUG] Status Code: ${response.statusCode}');
      print('[DEBUG] Raw Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data.map((sectionName, subjectList) {
          List<SubjectSelect> subjects = [];

          for (var json in subjectList) {
            try {
              subjects.add(SubjectSelect.fromJson(json));
            } catch (e) {
              print('[ERROR] Failed to parse subject: $json');
              print('[EXCEPTION] $e');
            }
          }

          return MapEntry(sectionName, subjects);
        });
      } else {
        print('[ERROR] Failed to fetch sections. Status: ${response.statusCode}, Body: ${response.body}');
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('[EXCEPTION] An error occurred while fetching sections: $e');
      rethrow;
    }
  }

}

