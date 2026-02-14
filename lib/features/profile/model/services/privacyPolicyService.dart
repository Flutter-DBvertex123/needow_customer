import 'dart:convert';

import 'package:newdow_customer/features/profile/model/privacyPolicyModel.dart';
import 'package:newdow_customer/utils/constants.dart';
import 'package:http/http.dart' as http;

abstract class PrivacyPolciyService{
  Future<Privacypolicymodel> getPrivacyPolicy();
}
class PrivacyPolciyServiceImpl extends PrivacyPolciyService{
  @override
  Future<Privacypolicymodel> getPrivacyPolicy() async {
    try {
      print("In privacy policy");
      final response = await http.get(Uri.parse("$baseUrl/privacy?audience=customer"));
      print("datai of privacy ${response.body}");
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final data = jsonResponse['data'][1];
        print("extracted data $data");
        return Privacypolicymodel.fromJson(data);
      } else {
        throw Exception('Failed to load policy: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching policy: $e');
    }
  }


}