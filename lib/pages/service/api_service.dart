import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://192.168.1.9:8000"; // Change to your actual API URL if using a physical device

  //@get
  Future<void> fetchData() async {
    final response = await http.get(Uri.parse("$baseUrl/api/auth/login/parent"));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("Response: $data");
    } else {
      print("Error: ${response.statusCode}");
    }
  }
  //@post login parent
  Future<bool> postData(String username, String password) async{
    final url = Uri.parse("$baseUrl/api/auth/login/parent");
    try{
      final response = await http.post(
        url,
        headers: {"Content-Type": "Application/json"},
        body: jsonEncode({
          "username": username,
          "password": password
        }),
      );
      if(response.statusCode == 201 || response.statusCode == 200){
        var responseData = jsonDecode(response.body);
        print("Post success: $responseData");
        return true;
      }else{
        print("Post error:${response.statusCode} - ${response.body}");
        return false;
      }
    }catch (e){
      print("Post exception: $e");
    }
    return false;
  }

  //register parent
  Future<bool> registerParent(
      String parentName,
      String parentAddress,
      String mobile_no,
      String email_add,
      Object userType,
      ) async {
    final url = Uri.parse("$baseUrl/api/pre-admission-parent-details/create");

    print("Sending API Request to: $url");
    print("Request Payload: ${jsonEncode({
      "parent_name": parentName,
      "parent_address" : parentAddress,
      "mobile_no":mobile_no,
      "email_add":email_add,
      "person_id":userType
    })}");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "parent_name": parentName,
          "parent_address" : parentAddress,
          "mobile_no":mobile_no,
          "email_add":email_add,
          "person_id":userType
        }),
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 201 || response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
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

}
