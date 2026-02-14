import 'dart:convert';

import 'package:newdow_customer/features/home/model/models/buisness_type_model.dart';
import 'package:http/http.dart' as http;
import '../../../../utils/constants.dart';

abstract class BusinessTypeService {
  Future<List<BusinessTypeModel>>getAllBusinessTypes();
}
 class BusinessTypeServiceImpl extends BusinessTypeService{
  @override
  Future<List<BusinessTypeModel>> getAllBusinessTypes() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/business-types'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print("busines data ${response.body}");
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        // Extract and refine list
        final List<dynamic> dataList = decoded['data'] ?? [];

        // Convert to model list
        final businessTypes = dataList
            .map((e) => BusinessTypeModel.fromJson(e))
            .toList();

        print('✅ Business types fetched: ${businessTypes.length}');
        return businessTypes;
      } else {
        print('❌ Failed to fetch business types. Status: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('⚠️ Error fetching business types: $e');
      return [];
    }
    throw UnimplementedError();
  }

 }