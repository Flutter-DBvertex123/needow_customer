import 'package:flutter/material.dart';

class OrderCancelDialog extends StatelessWidget {
  final String orderId;
  final VoidCallback onCancelOrder;
  final VoidCallback onSkip;

  const OrderCancelDialog({
    Key? key,
    required this.orderId,
    required this.onCancelOrder,
    required this.onSkip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Warning Icon
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.warning_amber_rounded,
                size: 48,
                color: Colors.red.shade400,
              ),
            ),
            const SizedBox(height: 20),

            // Title
            const Text(
              'Cancel Order?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),

            // Confirmation Message
            Text(
              'Are you sure you want to cancel this order?\nThis action cannot be undone.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade600,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),

            // Buttons
            Row(
              children: [
                // Skip Button
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onSkip();
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Cancel Order Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onCancelOrder();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade400,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Cancel Order',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Function to show the dialog
void showOrderCancelDialog(
    BuildContext context, {
      required String orderId,
      required VoidCallback onCancelOrder,
      VoidCallback? onSkip,
    }) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return OrderCancelDialog(
        orderId: orderId,
        onCancelOrder: onCancelOrder,
        onSkip: onSkip ?? () {},
      );
    },
  );
}

// Example usage in your widget
class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Details')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showOrderCancelDialog(
              context,
              orderId: '12345',
              onCancelOrder: () {
                // Handle cancel order action
                print('Order cancelled');
                // Call your API to cancel the order
              },
              onSkip: () {
                // Handle skip action
                print('Skipped cancellation');
              },
            );
          },
          child: const Text('Cancel Order'),
        ),
      ),
    );
  }
}