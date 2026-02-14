import 'dart:convert';
import 'dart:io';

import 'package:newdow_customer/features/product/models/model/ProductModel.dart';

import '../../../../../../utils/constants.dart';
import '../restaurentModel.dart';
import 'package:http/http.dart' as http;
abstract class RestaurentService{
  Future<List<String>> getCuisineTypes();
  Future<RestaurantResponse> getRestaurants({
    int page = 1,
    int limit = 10,
    String status = "",

  });
  Future<Map<String,dynamic>> getRestaurantItems(String restaurantId);
  Future<List<Restaurant>> getRestaurantsByCuisine(String cuisine);
  Future<Restaurant> getRestaurentById(id);
}
class RestaurentServiceImpl extends RestaurentService {
  Future<RestaurantResponse> getRestaurants({
    int page = 1,
    int limit = 10,
    String status = "",

  }) async {
    try {
      final url = Uri.parse(
          '$baseUrl/restaurants?page=$page&limit=$limit&status=$status');

      print('Fetching restaurants from: $url');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Request timeout'),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return RestaurantResponse.fromJson(jsonData);
      } else if (response.statusCode == 404) {
        throw Exception('Restaurants not found');
      } else if (response.statusCode == 500) {
        throw Exception('Server error');
      } else {
        throw Exception('Failed to load restaurants: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No internet connection');
    }
  }

  /// Fetch single restaurant by ID
  Future<Restaurant> getRestaurantById(String restaurantId) async {
    try {
      final url = Uri.parse('$baseUrl/restaurants/$restaurantId');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return Restaurant.fromJson(jsonData['data']);
      } else {
        throw Exception('Failed to load restaurant');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  /// Search restaurants by name or cuisine
  Future<RestaurantResponse> searchRestaurants({
    required String query,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final url = Uri.parse(
        '$baseUrl/restaurants?search=$query&page=$page&limit=$limit',
      );

      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return RestaurantResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to search restaurants');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  /// Filter restaurants by cuisine type
  Future<RestaurantResponse> filterByCuisine({
    required String cuisine,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final url = Uri.parse(
        '$baseUrl/restaurants?cuisine=$cuisine&page=$page&limit=$limit',
      );

      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return RestaurantResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to filter restaurants');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Map<String, dynamic>> getRestaurantItems(String restaurantId) async {
    print("Gete restauranmt items service");
    try {
      final url = Uri.parse('$baseUrl/products/restaurant/$restaurantId');
      print("Api call $url");

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      final decodedResponse = jsonDecode(response.body);
      print("Items of restaurant ${response.body}");
      print("Items of restaurant ${decodedResponse}");
      print(decodedResponse["statusCode"]);

      if (decodedResponse["statusCode"] == 200) {
        // Extract products and convert to ProductModel list
        final productsList = (decodedResponse["data"]['data'] as List)
            .map((product) =>
            ProductModel.fromJson(product as Map<String, dynamic>))
            .toList();

        return {
          "success": true,
          "data": productsList
        };
      } else {
        throw Exception(
            'Failed to load restaurant - Status: ${decodedResponse["statusCode"]}');
      }
    } catch (e) {
      print('Error in getRestaurantItems service: $e');
      throw Exception('Error: $e');
    }
  }


  Future<List<String>> getCuisineTypes() async {
    try {
      final uri = Uri.parse("$baseUrl/restaurants/cousinget/all");

      final response = await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
        },
      );
      print("cusins ${response.body}");
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return List<String>.from(body['data']);
      } else {
        throw Exception("Error: ${response.statusCode}");
      }
    } catch (e) {
      rethrow;
    }
  }


  Future<List<Restaurant>> getRestaurantsByCuisine(String cuisine) async {
    try {
      final url = Uri.parse('$baseUrl/restaurants/bycuisine');

      print('Fetching restaurants from: $url');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'cuisine': cuisine}),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Request timeout'),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        // final res = jsonData['data'].map((r) => Restaurant.fromJson(r)).toList();
        // print("Restaurants by cuisine: ${res.length}");
        // return res;
        final List<Restaurant> res =
        (jsonData['data'] as List)
            .map((r) => Restaurant.fromJson(r as Map<String, dynamic>))
            .toList();

        print("Restaurants by cuisine: ${res.length}");
        return res;
      } else if (response.statusCode == 404) {
        throw Exception('Restaurants not found');
      } else if (response.statusCode == 500) {
        throw Exception('Server error');
      } else {
        throw Exception('Failed to load restaurants: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No internet connection');
    }
  }

  @override
  Future<Restaurant> getRestaurentById(id) async {
    try {
      final url = Uri.parse('$baseUrl/restaurants/$id');

      print('Fetching restaurants from: $url');

      final response = await http.get(
        url,
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Request timeout'),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        // final res = jsonData['data'].map((r) => Restaurant.fromJson(r)).toList();
        // print("Restaurants by cuisine: ${res.length}");
        // return res;
        // final List<Restaurant> res =
        // (jsonData['data'] as List)
        //     .map((r) => Restaurant.fromJson(r as Map<String, dynamic>))
        //     .toList();

        //print("Restaurants by id: ${jsonData");
        return Restaurant.fromJson(jsonData);
      } else if (response.statusCode == 404) {
        throw Exception('Restaurants not found');
      } else if (response.statusCode == 500) {
        throw Exception('Server error');
      } else {
        throw Exception('Failed to load restaurants: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No internet connection');
    }
  }
}
