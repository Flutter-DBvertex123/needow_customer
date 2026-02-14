import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:newdow_customer/utils/constants.dart';
import 'package:http/http.dart' as http;
import '../model/ProductModel.dart';


abstract class ProductService{
  Future<List<ProductModel>> getPorducts(int? limit, String? category);
  Future<List<ProductModel>> getProductByBusinessType(String type,int limit,int page);
  Future<List<ProductModel>> getProductByCategory(String category);
  Future<List<ProductModel>> getProductBySubCategory(String categoryId);
}

class ProductServiceImpl extends ProductService {
  //getting products by categories
  @override
  Future<List<ProductModel>> getPorducts(int? limit, category) async {

      final uri = Uri.parse("$trendingProducts").replace(queryParameters: {
        "limit": limit.toString(),
        "type": category
      });
      final response = await http.get(uri, headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer YOUR_TOKEN_HERE", // optional
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("Dev :- Response body of ${uri.toString()} :- ${data} ");
        /*List<ProductModel> products =
        (data["data"]["data"] as List)
            .map((product) => ProductModel.fromJson(product))
            .toList();*/
        List<ProductModel> products =
        (data["data"] as List)
            .map((product) => ProductModel.fromJson(product))
            .toList();
        return products;
      } else {
        List<ProductModel> products = [];
        return products;
        throw Exception("Failed to load categories: ${response.statusCode}");

      }
      List<ProductModel> products = [];
      return products;
  }
  //getProductBybusinessType
  @override
  Future<List<ProductModel>> getProductByBusinessType(String type,int limit,int page) async {
    print("in get product by buissnes");
    print(type);
    try {
      final response = await http.get(
        Uri.parse('$getProductsByBusinessTpeCategory$type').replace(queryParameters: {
          "limit": limit.toString(),
          "page": page.toString()
        }),
        headers: {'Content-Type': 'application/json'},
      );
      print('here are');
      debugPrint(jsonDecode(response.body).toString());
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        // Extract nested list safely: data -> data
        final List<dynamic> dataList = decoded['data']?['data'] ?? [];
        print("lenght of buisis :- ${dataList.length}");
        // Convert each item to CategoryModel
        final categories = dataList
            .map((item) => ProductModel.fromJson(item))
            .toList();

        print('✅ BusinessType product fetched: ${categories.length}');
        return categories;
      } else {
        print('❌ Failed to fetch categories (status: ${response.statusCode})');
        return [];
      }
    } catch (e) {
      print('⚠️ Error fetching categories: $e');
      return [];
    }
  }



  @override
  Future<List<ProductModel>> getProductByCategory(String category) async {
    print("in get product by category");
    try {
      final response = await http.get(
        Uri.parse('$getProductsByCategory$category'),
        headers: {'Content-Type': 'application/json'},
      );
      print('category response body: ${response.body}');
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        // Extract nested list safely: data -> data
        final List<dynamic> dataList = decoded['data']?['data'] ?? [];

        // Convert each item to CategoryModel
        final categories = dataList
            .map((item) => ProductModel.fromJson(item))
            .toList();

        print('✅ Categories fetched: ${categories.length}');
        return categories;
      } else {
        print('❌ Failed to fetch categories (status: ${response.statusCode})');
        return [];
      }
    } catch (e) {
      print('⚠️ Error fetching categories: $e');
      return [];
    }
  }

  @override
  Future<List<ProductModel>> getProductBySubCategory(String categoryId) async {
    try {
      final response = await http.get(
        Uri.parse('$getProductsBySubCategory$categoryId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        // Extract nested list safely: data -> data
        final List<dynamic> dataList = decoded['data']?['data'] ?? [];

        // Convert each item to CategoryModel
        final categories = dataList
            .map((item) => ProductModel.fromJson(item))
            .toList();

        print('✅ Categories fetched: ${categories.length}');
        return categories;
      } else {
        print('❌ Failed to fetch categories (status: ${response.statusCode})');
        return [];
      }
    } catch (e) {
      print('⚠️ Error fetching categories: $e');
      return [];
    }
  }




}