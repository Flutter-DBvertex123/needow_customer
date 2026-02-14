import 'dart:convert';

import 'package:newdow_customer/features/cart/model/models/couponModel.dart';
import 'package:http/http.dart' as http;
import '../../../../utils/constants.dart';


abstract class CouponService{
  Future<List<CouponModel>> getCoupons();
  Future<double> redeemCoupon(String couponCode,String userId,double amount);
}

class CouponServiceImpl extends CouponService{

  @override
  Future<List<CouponModel>> getCoupons() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/coupons"));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        // Navigate into data -> data list
        final List<dynamic> couponList = jsonResponse['data']?['data'] ?? [];

        // Convert each item to Coupon model
        final List<CouponModel> coupons = couponList.map((e) => CouponModel.fromJson(e)).toList();

        return coupons;
      } else {
        throw Exception('Failed to load coupons: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching coupons: $e');
    }
  }
  @override
  Future<double> redeemCoupon(String couponCode,String userId,double amount) async {
    try{
      final response = await http.post(Uri.parse("$baseUrl/coupons/redeem",),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "userId": userId,
            "code": couponCode,
            "orderAmount":amount
          })
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw Exception('Request timeout');
        },
      );
print(" res: ${jsonDecode(response.body)}");
      if(response.statusCode == 200 || response.statusCode == 201){
        print({"response: ${jsonDecode(response.body)['data']['finalAmount']}"});
        return jsonDecode(response.body)['data']['finalAmount'].toDouble();
      }
      return 0;
    }catch(e){
      return 0;
    }
    throw UnimplementedError();

  }

}