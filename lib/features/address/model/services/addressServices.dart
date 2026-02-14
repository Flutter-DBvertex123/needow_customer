import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newdow_customer/utils/constants.dart';
import 'package:newdow_customer/utils/prefs.dart';
import '../addressModel.dart';
import '../creatAddressModel.dart';

abstract class AddressService{
  Future<AddressModel> createAddress(AddressModel address);
  Future<List<AddressModel>> getAddresses();
  Future<bool> updateDefaultAddress(String addressId, bool isDefault);
  Future<void> setDefaultAddress(String addressId);
  Future<bool> deleteAddress(String addressId);
}
class AddressServicesImpl extends AddressService {
  @override
  Future<AddressModel> createAddress(AddressModel address) async {
    try {
      String userId  = await AuthStorage.getUserFromPrefs().then((user) => user?.id) ?? "";
      print('user Id $userId');
      final response = await http.post(
        Uri.parse("$baseUrl/address/$userId"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(address.toJson()),
      );

      print('📡 Response Status: ${response.statusCode}');
      print('📡 Response Body: ${response.body}');

      if (response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['statusCode'] == 201) {
          final createdAddress = AddressModel.fromJson(jsonResponse['data']);
          print('✅ Address created successfully');
          return createdAddress;
        } else {
          throw Exception(jsonResponse['message'] ?? 'Failed to create address');
        }
      } else if (response.statusCode == 400) {
        final jsonResponse = jsonDecode(response.body);
        throw Exception(jsonResponse['message'] ?? 'Bad request');
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized. Please login again.');
      } else if (response.statusCode == 500) {
        throw Exception('Server error. Please try again later.');
      } else {
        throw Exception('Failed to create address: ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      print('❌ Network Error: ${e.message}');
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      print('❌ Error: $e');
      throw Exception('Error creating address: $e');
    }
  }

  /// Get All Addresses
  /// Get All Addresses
  @override
  Future<List<AddressModel>> getAddresses() async {
    try {
      print('🔵 Fetching addresses...');
      String userId = await AuthStorage.getUserFromPrefs()
          .then((user) => user?.id ?? "");

      final response = await http.get(
        Uri.parse("$baseUrl/address/$userId"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw Exception('Request timeout. Please try again.');
        },
      );

      print('📡 Response Status: ${response.statusCode}');
      print('📡 Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        print('📦 Response Data: $jsonResponse');

        // Check status code in response
        if (jsonResponse['statusCode'] == 200) {
          final outerData = jsonResponse['data'];

          // Handle nested data structure
          List<dynamic> addressesList;

          if (outerData is Map && outerData.containsKey('data')) {
            // data.data format - array inside data object
            addressesList = outerData['data'] as List;
            print('✅ Found nested data.data with ${addressesList.length} addresses');
          } else if (outerData is List) {
            // Direct array format
            addressesList = outerData;
            print('✅ Found direct data array with ${addressesList.length} addresses');
          } else if (outerData is Map && outerData.containsKey('addresses')) {
            // addresses key format
            addressesList = outerData['addresses'] as List;
            print('✅ Found data.addresses with ${addressesList.length} addresses');
          } else {
            print('❌ Unexpected response format: ${outerData.runtimeType}');
            throw Exception(
                'Unexpected response format. Expected data.data, data, or data.addresses');
          }

          // Convert to AddressModel list
          final addresses = addressesList
              .map((item) => AddressModel.fromJson(item as Map<String, dynamic>))
              .toList();

          print('✅ Successfully fetched ${addresses.length} addresses');

          // Debug: Print all addresses with isDefault status
          for (var addr in addresses) {
            print('📍 Address: ${addr.landmark} - City: ${addr.city} - Default: ${addr.isDefault}');
          }

          // Check if any default address exists
          final hasDefault = addresses.any((a) => a.isDefault);
          print('🔍 Has default address: $hasDefault');

          return addresses;
        } else {
          throw Exception(
              jsonResponse['message'] ?? 'Failed to fetch addresses');
        }
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized. Please login again.');
      } else if (response.statusCode == 400) {
        final jsonResponse = jsonDecode(response.body);
        throw Exception(jsonResponse['message'] ?? 'Bad request');
      } else if (response.statusCode == 500) {
        throw Exception('Server error. Please try again later.');
      } else {
        throw Exception('Failed to fetch addresses: ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      print('❌ Network Error: ${e.message}');
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      print('❌ Error: $e');
      throw Exception('Error fetching addresses: $e');
    }
  }

  @override
  Future<void> setDefaultAddress(String addressId) {
    // TODO: implement setDefaultAddress
    throw UnimplementedError();
  }

  /// Get Address by ID
  // Future<AddressModel> getAddressById(String addressId) async {
  //   try {
  //     print('🔵 Fetching address: $addressId');
  //
  //     final token = await _getAuthToken();
  //
  //     final response = await http.get(
  //       Uri.parse('$getAddressByIdEndpoint/$addressId'),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //       },
  //     ).timeout(
  //       const Duration(seconds: 30),
  //       onTimeout: () {
  //         throw Exception('Request timeout. Please try again.');
  //       },
  //     );
  //
  //     print('📡 Response Status: ${response.statusCode}');
  //     print('📡 Response Body: ${response.body}');
  //
  //     if (response.statusCode == 200) {
  //       final jsonResponse = jsonDecode(response.body);
  //
  //       if (jsonResponse['success'] == true || jsonResponse['success'] == null) {
  //         final address = AddressModel.fromJson(
  //           jsonResponse['data'] as Map<String, dynamic>,
  //         );
  //
  //         print('✅ Address fetched successfully');
  //         return address;
  //       } else {
  //         throw Exception(jsonResponse['message'] ?? 'Failed to fetch address');
  //       }
  //     } else if (response.statusCode == 404) {
  //       throw Exception('Address not found');
  //     } else if (response.statusCode == 401) {
  //       throw Exception('Unauthorized. Please login again.');
  //     } else if (response.statusCode == 400) {
  //       final jsonResponse = jsonDecode(response.body);
  //       throw Exception(jsonResponse['message'] ?? 'Bad request');
  //     } else if (response.statusCode == 500) {
  //       throw Exception('Server error. Please try again later.');
  //     } else {
  //       throw Exception('Failed to fetch address: ${response.statusCode}');
  //     }
  //   } on http.ClientException catch (e) {
  //     print('❌ Network Error: ${e.message}');
  //     throw Exception('Network error: ${e.message}');
  //   } catch (e) {
  //     print('❌ Error: $e');
  //     throw Exception('Error fetching address: $e');
  //   }
  // }
  @override
  Future<bool> updateDefaultAddress(String addressId, bool isDefault) async {
    try {
      final url = Uri.parse('$baseUrl/address/$addressId');

      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer YOUR_TOKEN_HERE',
        },
        body: jsonEncode({
          'isDefault': isDefault,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Address updated successfully: $responseData');
        return responseData['data']["isDefault"];
      } else {
        throw Exception('Failed to update address: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  @override
  Future<bool> deleteAddress(String addressId) async {
    try {
      final url = Uri.parse('$baseUrl/address/$addressId');

      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Address deleted successfully: $responseData');
        return true;
      } else {
        return false;
        throw Exception('Failed to update address: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}