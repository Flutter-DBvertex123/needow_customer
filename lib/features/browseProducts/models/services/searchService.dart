import 'dart:convert';

import '../../../../utils/constants.dart';
import '../../../cart/model/models/cartModel.dart';
import '../../../product/models/model/ProductModel.dart';
import 'package:http/http.dart' as http;

abstract class SearchService{
  Future<List<ProductModel>> searchProduct(String query);
}
class SearchServiceImpl extends SearchService {
  @override
 Future<List<ProductModel>> searchProduct(String query) async {
    {
      final url = Uri.parse(
        '$baseUrl/products?page=1&limit=10&search=$query',
      );

      try {
        final response = await http.get(url, headers: {
          'Content-Type': 'application/json',
        });

        if (response.statusCode == 200) {
          final decoded = json.decode(response.body);
          print("✅ Success: $decoded");

          final List<dynamic> productJsonList = decoded["data"]["data"];

          final List<ProductModel> productList = productJsonList
              .map((product) => ProductModel.fromJson(product as Map<String, dynamic>))
              .toList();

          print("🟢 Parsed ${productList.length} products");

          return productList;
        } else {
          throw Exception('Failed to load products: ${response.statusCode}');
        }
      } catch (e) {
        print('❌ API Error: $e');
        rethrow;
      }
    }
  }}