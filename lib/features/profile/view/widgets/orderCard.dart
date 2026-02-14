import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../orders/model/models/orderModel.dart';
import '../../../orders/view/view_order_screen.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  final VoidCallback? onReorder;

  const OrderCard({
    Key? key,
    required this.order,
    this.onReorder,
  }) : super(key: key);

  Color _getStatusColor() {
    switch (order.status.toLowerCase()) {
      case 'delivered':
        return const Color(0xFF00BFA5);
      case 'cancelled':
        return const Color(0xFFBDBDBD);
      case 'pending':
        return const Color(0xFFFFA726);
      default:
        return const Color(0xFF9E9E9E);
    }
  }

  IconData _getStatusIcon() {
    switch (order.status.toLowerCase()) {
      case 'delivered':
        return Icons.check_circle;
      case 'cancelled':
        return Icons.cancel;
      case 'pending':
        return Icons.schedule;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => ViewOrderScreen(order: order)),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Product Image
              Container(
                padding: const EdgeInsets.all(8),
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  color: const Color(0xFFEBEBEB),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    order.items[0].image[0].replaceAll(RegExp(r'[\[\]]'), ''),
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.broken_image,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Order Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status with Icon
                    Row(
                      children: [
                        Icon(
                          _getStatusIcon(),
                          color: _getStatusColor(),
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          order.status,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: _getStatusColor(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Date
                    Text(
                      order.createdAt.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Amount
                    Text(
                      "₹${order.totalAmount.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              // Next Arrow
              Icon(
                Icons.navigate_next_outlined,
                color: Colors.grey[400],
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Model class
class Order {
  final String status;
  final String placedAt;
  final double totalAmount;
  final List<OrderItem> items;

  Order({
    required this.status,
    required this.placedAt,
    required this.totalAmount,
    required this.items,
  });
}

class OrderItem {
  final List<String> image;

  OrderItem({required this.image});
}

// Placeholder for ViewOrderScreen

