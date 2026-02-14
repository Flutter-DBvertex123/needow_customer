import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:newdow_customer/features/auth/model/models/userModel.dart';
import 'package:newdow_customer/features/profile/controller/profile_controller.dart';
import 'dart:io';

import 'package:newdow_customer/utils/constants.dart';

import '../../../../utils/prefs.dart';
import '../userModel.dart';
abstract class ProfileService {
  Future<bool> updateUserProfile(
      String? userId,
      String? name,
      String? email,
      String? dob,
      String? gender,
      File? profileImage,
      );
  Future<UserModel?> getUserDetails(String userId);
}
class ProfileServiceImpl extends ProfileService {



  //getUser
  Future<UserModel?> getUserDetails(String userId) async {
    try{
      print("uid from login $userId");
      Uri uri = Uri.parse("$baseUrl/users/${ userId == null ? userId : userId }");
      final  response = await http.get(uri);
      if(response.statusCode == 200){
        final decodedReponse = jsonDecode(response.body);
        print("Dev :- Get Agent body $decodedReponse");
        final user =  UserModel.fromJson(decodedReponse["data"]);
          print("user saved");
          return user;
        await AuthStorage.saveUserInPrefs(user);
         //Get.find<ProfileController>().savedData.value = await AuthStorage.getUserFromPrefs();
      }

    }catch(e){
      print("Error while geting user $e");
    }
    return null;
  }



  Future<bool> updateUserProfile(
     String?userId,
     String? name,
     String?email,
     String? dob,
     String? gender,
    File? profileImage, // optional file
  ) async {
    final url = Uri.parse('$baseUrl/users/$userId');
    final token = 'your_auth_token_here'; // if auth required

    try {
      // Create a Multipart PUT request
      var request = http.MultipartRequest('PUT', url);

      // Add headers
      request.headers.addAll({
         // optional
        'Accept': 'application/json',
      });
      // Add fields

      request.fields['name'] = name ?? "";
      request.fields['email'] = email ?? "";
      request.fields['dob'] = dob ?? "";
      request.fields['gender'] = gender ?? "";

      // If there’s an image, attach it
      if (profileImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'photo', // key name expected by backend
          profileImage.path,
        ));
      }

      // Send the request
      var response = await request.send();

      // Convert streamed response to normal
      var responseBody = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        print('✅ Profile updated successfully!');

        print(responseBody.body);
        return true;
        print(jsonDecode(responseBody.body));
      } else {
        print('❌ Failed to update profile. Status: ${response.statusCode}');
        print(responseBody.body);
        return false;
      }
    } catch (e) {
      print('⚠️ Error updating profile: $e');
      return false;
    }
  }

}