import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newdow_customer/features/orders/model/models/createOrderModel.dart';
import 'package:newdow_customer/features/orders/model/models/orderModel.dart';

import '../../../../utils/constants.dart';
import '../models/orderTrackingModel.dart';

abstract class OrderService {
  Future<Map<String,dynamic>> createOrder(CreateOrderModel order);
  Future<List<OrderModel>> getUserOrders({required String userId, int page = 1, int limit = 10,});
  Future<OrderModel> getOrderById(String orderId);
  Future<OrderTrackingModel> getOrderTracking(String orderId);
  Future<bool> rateDeliveryAgent(String deliveryAgentId, String userId,String comment,String orderId,int rating);
  Future<Map<String, dynamic>> updateOrderStatus({
    required String orderId,
    required String status,
    required String note,
  });

}
class OrderServiceImpl extends OrderService {
  //create new order
  @override
  Future<Map<String, dynamic>> createOrder(CreateOrderModel order) async {
    print("ORDER JSON => ${jsonEncode(order.toJson())}");
    final url = Uri.parse("$baseUrl/orders"); // replace with your API endpoint

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer YOUR_TOKEN_HERE', // optional
        },
        body: jsonEncode(order.toJson()),
      );
      print("Order raw response :- ${response.body}");
      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        return {
          "success": true,
          "data": responseData["data"]["_id"],
        };
      } else {
        return {
          "success": false,
          "data": {
            "statusCode": response.statusCode,
            "message": "Failed to create order",
            "body": response.body,
          }
        };
      }
    } catch (error) {
      return {
        "success": false,
        "data": {
          "message": "Something went wrong",
          "error": error.toString(),
        }
      };
    }
  }

  Future<List<OrderModel>> getUserOrders({
    required String userId,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      print("In get order service");
      final String url = '$baseUrl/orders/user/$userId?page=$page&limit=$limit';

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          // Add authorization token if needed
          // 'Authorization': 'Bearer $token',
        },
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () => throw TimeoutException('Request timeout'),
      );

      print("Order response status: ${response.statusCode}");
      print("Order response body: ${response.body}");

      if (response.statusCode == 200) {
        print("Response 200 - Parsing data");

        // Decode response
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        print("Decoded JSON keys: ${jsonData.keys}");

        // Check if data exists
        if (!jsonData.containsKey('data')) {
          throw Exception('No data key in response');
        }

        final dataWrapper = jsonData['data'];
        print("Data wrapper type: ${dataWrapper.runtimeType}");
        print("Data wrapper: $dataWrapper");

        // Check if nested data exists
        if (dataWrapper is! Map<String, dynamic>) {
          throw Exception('Data is not a map');
        }

        if (!dataWrapper.containsKey('data')) {
          throw Exception('No nested data key in response');
        }

        final ordersList = dataWrapper['data'];
        print("Orders list type: ${ordersList.runtimeType}");
        print("Orders list length: ${ordersList.length}");

        // Ensure it's a list before mapping
        if (ordersList is! List) {
          throw Exception('Orders data is not a list');
        }

        // Map to OrderModel
        final orders = (ordersList as List<dynamic>)
            .map((order) {
          print("Mapping order: ${order['orderNumber']}");
          return OrderModel.fromJson(order as Map<String, dynamic>);
        })
            .toList();

        print("Successfully parsed ${orders.length} orders");
        if (orders.isNotEmpty) {
          print("First order: ${orders.first.orderNumber}");
        }

        return orders;
      } else if (response.statusCode == 404) {
        throw Exception('Orders not found');
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized access');
      } else {
        throw Exception(
            'Failed to fetch orders: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print("Error in getUserOrders: $e");
      throw Exception('Error fetching orders: $e');
    }
  }

  Future<OrderModel> getOrderById(String orderId) async {
    try {
      print("In get order by id screen");
      print("Fetching order with ID: $orderId");
      final String url = '$baseUrl/orders/$orderId';

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer $token',
        },
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () => throw Exception('Request timeout'),
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print("Order fetched successfully");

        final order =
        OrderModel.fromJson(jsonData['data']);
        print(orderId);
        print(
            "Order: ${order.orderNumber}, Customer: ${order.user}");
        return order;
      } else if (response.statusCode == 404) {
        throw Exception('Order not found');
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized access');
      } else {
        throw Exception('Failed to fetch order: ${response.statusCode}');
      }
    } catch (e) {
      print("Error in getOrderById: $e");
      throw Exception('Error fetching order: $e');
    }
  }
  Future<OrderTrackingModel> getOrderTracking(String orderId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/orders/$orderId/tracking'),
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 30));
      print("tracking response :- ${response.body}");
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print("data in ser ${jsonData}");
        return OrderTrackingModel.fromJson(jsonData);
      } else {
        throw Exception('Failed to load tracking: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
  Future<bool> rateDeliveryAgent(String deliveryAgentId, String userId,String comment,String orderId,int rating) async {
    print("delivery man id $deliveryAgentId");
    final String url = '$baseUrl/delivery-agents/$deliveryAgentId/rate';

    final Map<String, dynamic> requestBody = {
      "orderId": orderId,
      "rating": rating,
      "comment": comment,
      "userId": userId
    };

    try {
      print("Rating Request Body: $url");
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Success: ${response.body}');
        return true;
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      print('Exception: $e');
      return false;
    }
  }
  ///Update order status
  // Update order status
  Future<Map<String, dynamic>> updateOrderStatus({
    required String orderId,
    required String status,
    required String note,
  }) async {
    try {
      // Construct the URL with orderId and status as query parameter
      final url = Uri.parse('$baseUrl/orders/$orderId/status?status=$status');
      print("Update Order Status URL: $url");
      // Prepare the JSON body
      final body = jsonEncode({
        'note': note,
      });

      // Make the POST request
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          // Add authorization header if needed
          // 'Authorization': 'Bearer YOUR_TOKEN',
        },
        body: body,
      );
      print("Update Order Status Response: ${response.body}");
      // Handle the response
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'data': jsonDecode(response.body),
          'message': 'Order status updated successfully'
        };
      } else {
        return {
          'success': false,
          'error': 'Failed to update order status',
          'statusCode': response.statusCode,
          'message': response.body
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'Exception occurred',
        'message': e.toString()
      };
    }
  }

}



 /* Future<List<OrderModel>> getUserOrders({
    required String userId,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      print("In get order service");
      final String url =
          '$baseUrl/orders/user/$userId?page=$page&limit=$limit';

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          // Add authorization token if needed
          // 'Authorization': 'Bearer $token',
        },
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () => throw TimeoutException('Request timeout'),
      );
      print(" order response ${response.body}");
      if (response.statusCode == 200) {
        print("response 200");
        //final jsonData = jsonDecode(response.body);
        //print(jsonData);
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        print("map bodya :-$jsonData");
        // Access nested data correctly
        final ordersList = (jsonData['data']['data'] as List<dynamic>)
            .map((order) => OrderModel.fromJson(order as Map<String, dynamic>))
            .toList();
        //print("order id${ordersList.first.orderNumber}");
        return ordersList;
      } else if (response.statusCode == 404) {
        throw Exception('Orders not found');
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized access');
      } else {
        throw Exception('Failed to fetch orders: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching orders: $e');
    }
  }*/
