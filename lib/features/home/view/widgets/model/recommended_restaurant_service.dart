import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newdow_customer/features/home/view/widgets/model/recommendedRestaurantModel.dart';
import 'package:newdow_customer/utils/constants.dart';
// import 'recommended_restaurant_model.dart';

class RecommendedRestaurantService {
  static const String _url =
      "${baseUrl}/restaurants/recommended/all";

  static Future<Map<String ,dynamic>?> fetchRestaurants() async {
    try {
      print("fsdgdgdgdfg");
      final response = await http.get(
        Uri.parse("$_url"),
        headers: {'Content-Type': 'application/json'},
      );
      print("dfgfbcvn bvbnvn v${response.body}");
      if (response.statusCode == 200) {
        //return RecommendedRestaurantModel.fromJson(
         return jsonDecode(response.body);



      } else {
        print("API Error ${response.statusCode}");
      }
    } catch (e) {
      print("API Exception: $e");
    }
    return null;
  }
}
