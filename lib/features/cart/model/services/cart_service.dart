import 'dart:convert';
import 'dart:io';

import 'package:newdow_customer/features/address/model/addressModel.dart';
import 'package:newdow_customer/features/cart/model/models/addToCartModel.dart';
import 'package:newdow_customer/utils/constants.dart';
import 'package:newdow_customer/utils/prefs.dart';
import 'package:http/http.dart' as http;

import '../../../orders/model/models/orderModel.dart';
import '../models/cartCheckOutModel.dart';
import '../models/cartItemsModel.dart';
import '../models/cartModel.dart';

abstract class CartService{
 Future<UsersCartModel> getUsersCart();
 Future<bool> addToCart(Map<String, dynamic> cart);
 Future<Map<String,dynamic>> removeCartItem(String cartId);
 Future<bool> updateCart({
   required String cartId,
   required Map<String, dynamic> body,
 });
 Future<CartCheckoutModel> calculateCheckout({
   required String userId,
   required AddressModel deliveryAddress,
 });
 Future<Map<String,dynamic>> uploadPrescription(File file);
}

class CartServiceImpl extends CartService{
  @override
  Future<UsersCartModel> getUsersCart() async {
    final userData = await AuthStorage.getUserFromPrefs();
    final userId = userData!.id;

    final Uri uri = Uri.parse("$getUsersCartByUserId/$userId");

    print("Dev :- API Call $uri");

    try {
      final response = await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );

      print("Dev :- Cart Response ${response.statusCode} ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedResponse = jsonDecode(response.body);

        final List data = decodedResponse["data"] ?? [];

        if (data.isEmpty) {
          return UsersCartModel.empty();
        }

        return UsersCartModel.fromJson(data.first);
      }

      if (response.statusCode == 404) {
        return UsersCartModel.empty();
      }

      throw Exception("Unexpected error: ${response.statusCode}");
    } catch (e) {
      print("Error fetching user cart: $e");
      return UsersCartModel.empty();
    }
  }

  // @override
  // Future<UsersCartModel?> getUsersCart() async {
  //   final userData = await AuthStorage.getUserFromPrefs();
  //   final userId = userData!.id;
  //
  //   // 🔥 Use path param instead of query if backend expects /cart/:id
  //   Uri uri = Uri.parse("$getUsersCartByUserId/$userId");
  //
  //   print("Dev :- API Call $uri");
  //
  //   try {
  //     final response = await http.get(
  //       uri,
  //       headers: {
  //         "Content-Type": "application/json",
  //         "Accept": "application/json",
  //       },
  //     );
  //
  //     print("Dev :- Cart Response ${response.statusCode} ${response.body}");
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       final decodedResponse = jsonDecode(response.body);
  //       print("cart data $decodedResponse");
  //       // Assuming response looks like: { "statusCode": 200, "data": [ ... ] }
  //       UsersCartModel usersCart = (decodedResponse["data"] as List)
  //           .map((cart) => UsersCartModel.fromJson(cart))
  //           .toList().first;
  //
  //
  //       return usersCart == null ? UsersCartModel.empty() : usersCart;
  //     } else if(response.statusCode == 404) {
  //       final decodedResponse = jsonDecode(response.body);
  //       return UsersCartModel.empty();
  //       throw Exception(
  //         decodedResponse['message']
  //       );
  //
  //     }
  //     return UsersCartModel.empty();
  //   } catch (e) {
  //     return UsersCartModel.empty();
  //     throw Exception("Error fetching user cart: $e");
  //   }
  // }

  // @override
  // Future<Map<String, dynamic>> addToCart(Map cart) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("$baseUrl/cart"),
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode(cart.toJson()),
  //     );
  //
  //     // Debug print
  //     print("🟩 Cart Add Response: ${response.body}");
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       final jsonResponse = jsonDecode(response.body);
  //
  //       // ✅ Always ensure we’re returning a Map
  //       if (jsonResponse is Map<String, dynamic>) {
  //         return jsonResponse;
  //       } else {
  //         // If backend returns a string, wrap it inside a map
  //         return {"message": jsonResponse.toString()};
  //       }
  //     } else {
  //       throw Exception('Failed to add product to cart: ${response.body}');
  //     }
  //   } catch (e) {
  //     throw Exception('Error adding to cart: $e');
  //   }
  // }
  @override
  Future<bool> addToCart(Map<String, dynamic> cart) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/cart"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(cart), // ✔ sending raw Map, not model.toJson()
      );

      print("🟩 Cart Add Response: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);

        // Ensure return is always a Map
        if (jsonResponse is Map<String, dynamic>) {
          return true;
        } else {
          // If backend returns string or array, wrap it safely
          return false;
        }
      } else {
        throw Exception('Failed to add product to cart: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error adding to cart: $e');
    }
  }

  //remove cart
  Future<Map<String,dynamic>> removeCartItem(String cartId) async {
    try {
      final url = Uri.parse('$baseUrl/cart/$cartId');

      final response = await http.delete(
        url,
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        print("🗑️ Cart deleted successfully");
       final decodedBody = jsonDecode(response.body);
        return {"message": decodedBody["message"].toString()};
      } else {
        print("❌ Failed to delete cart: ${response.body}");
        return {"message": jsonDecode(response.body)};
      }
    } catch (e) {
      print("⚠️ Error deleting cart: $e");
      return {"message": "Remove cart failed"};
    }
  }

 /* Future<bool> updateCart({
  required String cartId,
  required Map<String, dynamic> body,
}) async {
    try {
      // Build the request body
      final Map<String, dynamic> body = {
        'userId': body['userId'],
        'items': items.map((item) => item.toJson()).toList(),
        if (placeholder != null) 'placeholder': placeholder,
      };

      // Make the API call
      final response = await http.put(
        Uri.parse('$baseUrl/cart/$cartId'),
        headers: {
          'Content-Type': 'application/json',
          // Add authorization header if needed
          // 'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw Exception('Request timeout');
        },
      );

      // Check if status code is 200
      if (response.statusCode == 200) {
        // Optionally parse and handle the response data
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print('Cart updated successfully: ${responseData['message']}');
        return true;
      } else {
        print('Failed to update cart: ${response.statusCode}');
        print('Response: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error updating cart: $e');
      return false;
    }
  }*/
  Future<bool> updateCart({
    required String cartId,
    required Map<String, dynamic> body,
  }) async {
    print("in Update cart service");
    print("json req data ${body["items"].length}");
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/cart'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw Exception('Request timeout');
        },
      );
      print("Update cart :- ${response.body}");
      if (jsonDecode(response.body)["statusCode"] == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print('Cart updated successfully: ${responseData['message']}');
        return true;
      } else {
        print('Failed to update cart: ${response.statusCode}');
        print('Response: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error updating cart: $e');
      return false;
    }
  }

  ///calculate cart checkout total
  Future<CartCheckoutModel> calculateCheckout({
    required String userId,
    required AddressModel deliveryAddress,
  }) async {
    final url = Uri.parse('$baseUrl/cart/calculate-checkout');
    print(userId);
    print(deliveryAddress.latitude);
    print(deliveryAddress.longitude);
    print(deliveryAddress);
    print(deliveryAddress.city);
    print(deliveryAddress.pincode);
    final body = {
      "userId": userId,
      "deliveryAddress": {
        "latitude": deliveryAddress.latitude,
        "longitude": deliveryAddress.longitude,
        "address": "${deliveryAddress.street}, ${deliveryAddress.landmark}, ${deliveryAddress.city}, ${deliveryAddress.state}, ${deliveryAddress.country}",
        "city": deliveryAddress.city,
        "postalCode": deliveryAddress.pincode,
      }
    };

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
    print("calcualted ${response.body}");

    if (response.statusCode == 201 || response.statusCode == 201) {
      final decoded = jsonDecode(response.body);

      return CartCheckoutModel.fromJson(decoded['data']);
    } else {
      throw Exception(
        'Failed to calculate checkout: ${response.body}',
      );
    }
  }

  Future<Map<String, dynamic>> uploadPrescription(File file) async {
    try {
      var uri = Uri.parse('$baseUrl/upload/documents');

      var request = http.MultipartRequest('POST', uri);

      // Add file
      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          file.path,
        ),
      );

      // Add headers if needed
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        // 'Authorization': 'Bearer YOUR_TOKEN',
      });

      // Send request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Upload successful: ${response.body}');

        // Parse JSON response
        final data = json.decode(response.body);
        return {
          'success': data['success'] ?? false,
          'url': data['data']?['url'] ?? '',
          'message': data['message'] ?? 'File uploaded successfully',
        };
      } else {
        print('Upload failed: ${response.statusCode} - ${response.body}');
        return {
          'success': false,
          'url': '',
          'message': 'Upload failed',
        };
      }
    } catch (e) {
      print('Upload error: $e');
      return {
        'success': false,
        'url': '',
        'message': 'Upload error: $e',
      };
    }
  }


}

