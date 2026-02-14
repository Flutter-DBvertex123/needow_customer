
import 'dart:convert';

import 'package:get/get.dart';
import 'package:newdow_customer/features/home/controller/buisnessController.dart';
import 'package:newdow_customer/features/product/models/model/ProductModel.dart';

import '../../../../utils/constants.dart';
import '../models/categoryAndSubCategoryModel.dart';
import 'package:http/http.dart' as http;
abstract class CategoryAndSubcategoryService  {

  Future<Map<String,dynamic>> getCategories(String businessType);
  Future<Map<String,dynamic>> getSubCategories(String categoryId);
}
class CategoryAndSubcategoryServiceImpl extends CategoryAndSubcategoryService {
  @override
  Future<Map<String,dynamic>> getCategories(String businessType) async {
    
    try {
      Uri uri = Uri.parse("${getCatetoriesbybusinesstype}$businessType");
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);

        if (jsonBody['data'] != null && jsonBody['data'] is List) {
          final data=  (jsonBody['data'] as List)
              .map((item) => CategoryModel.fromJson(item))
              .toList();
          print(data);
          return {"success":true,"data":data};
        } else {
          return {"success":false,"message": jsonBody["message"]};
        }
      } else {
        return {"success":false,"message": jsonDecode(response.body)['message']};
      }
    } catch (e) {
      throw Exception("Error fetching categories: $e");
    }

  }

  @override
  Future<Map<String,dynamic>> getSubCategories(String categoryId) async {
    try {
      Uri uri = Uri.parse("$getSubcatetoriesByCategory$categoryId");
      final response = await http.get(uri);
      print(response.body);
      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);

        if (jsonBody['data'] != null && jsonBody['data'] is List) {
          final data = (jsonBody['data'] as List)
              .map((item) => SubCategoryModel.fromJson(item))
              .toList();
          return {"success":true,"data":data};
        } else {
          return {"success":false,"message": jsonBody["message"]};
        }
      } else {
        return {"success":false,"message": jsonDecode(response.body)['message']};
      }
    } catch (e) {
      throw Exception("Error fetching subcategories: $e");
    }
  }
}

