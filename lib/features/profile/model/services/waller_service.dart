import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newdow_customer/utils/constants.dart';
import '../wallet_model.dart';


abstract class WalletService {
  Future<List<WalletModel>> getWalletHistory(String userId);
  Future<bool> addMoney({
    required String userId,
    required double amount,
    required String description,
  });
  Future<bool> createWallet({
    required String userId,
    required double initialBalance,
  });
  Future<double> getWalletBalance(String walletId);
  Future<bool> withdrawFromWallet(String userId,double amount,String description);
}
class WalletServiceImpl implements WalletService {
@override
  Future<List<WalletModel>> getWalletHistory(String userId) async {
  print("in wallet history");
    final uri = Uri.parse('$walletUrl/$userId/history');

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return WalletModel.fromJsonList(data);
      }else if(response.statusCode == 404){
        return [];
      }
      else {
        throw Exception(
            'Failed to load wallet history: ${response.statusCode}');
      }
    } catch (e) {
      print('WalletService Error: $e');
      rethrow;
    }
  }
  @override
  Future<double> getWalletBalance(String userId) async {
    final uri = Uri.parse('$walletUrl/$userId/balance');

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return (data['balance'] as num).toDouble();
      } else if(response.statusCode == 404){
        return -1;
      }
      else {
        throw Exception(
            'Failed to load wallet balance: ${response.statusCode}');
      }
    } catch (e) {
      print('WalletService Error (Balance): $e');
      rethrow;
    }
  }

  @override
  Future<bool> addMoney({
    required String userId,
    required double amount,
    required String description,
  }) async {
    try {
      // Validate inputs
      if (userId.isEmpty) {
        print('Error: userId cannot be empty');
        return false;
      }
      if (amount <= 0) {
        print('Error: amount must be greater than 0');
        return false;
      }
      if (description.isEmpty) {
        print('Error: description cannot be empty');
        return false;
      }

      // Build request body
      final Map<String, dynamic> body = {
        'userId': userId,
        'amount': amount,
        'description': description,
      };

      print('Adding money - UserId: $userId, Amount: $amount, Description: $description');

      // Make API call
      final response = await http.post(
        Uri.parse('$baseUrl/wallet/deposit'), // Adjust endpoint as needed
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
      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print('Money added successfully: ${responseData['message']}');
        return true;
      } else {
        print('Failed to add money: ${response.statusCode}');
        print('Response: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error adding money: $e');
      return false;
    }
  }
  //create wallet
 Future<bool> createWallet({
  required String userId,
  required double initialBalance,
}) async {
  try {
    final url = Uri.parse('$baseUrl/wallet/create');

    final requestBody = {
      'userId': userId,
      'initialBalance': initialBalance,
    };

    print('Creating wallet with body: $requestBody');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        // Add authorization header if needed
        // 'Authorization': 'Bearer YOUR_TOKEN',
      },
      body: jsonEncode(requestBody),
    ).timeout(
      Duration(seconds: 30),
      onTimeout: () {
        throw Exception('Request timeout');
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if ( response.statusCode == 201) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      print('Wallet created successfully: $responseData');
      return true;
    } else if (response.statusCode == 400) {
      throw Exception('Bad request: ${response.body}');
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized: Invalid credentials');
    } else if (response.statusCode == 500) {
      throw Exception('Server error: Please try again later');
    } else {
      throw Exception('Failed to create wallet: ${response.statusCode}');
    }
  } catch (e) {
    print('Error creating wallet: $e');
    return false;
  }
}



Future<bool> withdrawFromWallet(String userId,double amount,String description) async {
  // Replace with your actual base URL
  final String url = '$baseUrl/wallet/withdraw';

  final Map<String, dynamic> requestBody = {
    "userId": userId,
    "amount": amount,
    "description": description
  };

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 201) {
      // Success
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      print('Withdrawal successful: $responseData');
      return true;
    } else {
      // Error
      print('Failed with status code: ${response.statusCode}');
      print('Response: ${response.body}');
      return false;
    }
  } catch (e) {
    print('Error: $e');
    return false;
  }
}
}