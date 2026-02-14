import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:newdow_customer/features/orders/controllers/orderController.dart';
import 'package:newdow_customer/features/orders/view/reorder_screen.dart';
import 'package:newdow_customer/features/orders/view/track_order_screen.dart';
import 'package:newdow_customer/utils/apptheme.dart';
import 'package:newdow_customer/utils/getSize.dart';
import 'package:newdow_customer/widgets/snackBar.dart';

import '../../../utils/constants.dart';
import '../model/models/orderModel.dart';

class LeaveReviewScreen extends StatefulWidget {
  OrderModel order;
   LeaveReviewScreen({Key? key,required this.order}) : super(key: key);

  @override
  State<LeaveReviewScreen> createState() => _LeaveReviewScreenState();
}

class _LeaveReviewScreenState extends State<LeaveReviewScreen> {
  int selectedRating = 4; // Default 4 stars selected
  final TextEditingController _reviewController = TextEditingController();

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:  IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () => Get.back(),
    ),
        toolbarHeight: 60,
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text(
          'Leave Review',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            // Green Header Section
            Container(
              width: 1.toWidthPercent(),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius:  BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  // Header with back button
                  /*Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () => Get.off(TrackOrderScreen()),
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Text(
                          'Leave Review',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 0.2.toWidthPercent(),)
                      ],
                    ),
                  )*/

                  // Success Icon and Message
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 40),
                    child: Column(
                      children: [
                        Container(
                          width: 80,
                          height: 0.08.toHeightPercent(),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check,
                            size: 50,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Order Delivered!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Your food from "The Spicy Spoon"',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          'has arrived!',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Review Section
            Expanded(
              child: SingleChildScrollView(
                physics:BouncingScrollPhysics(), // <-- allows scrolling

                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    SizedBox(height: 12,),
                    const Text(
                      'How is your order?',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Divider(height: 2,color: AppColors.primary.withValues(alpha: 0.5),),
                    const SizedBox(height: 14),
                    // Rating Stars
                    const Text(
                      'Your overall rating',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedRating = index + 1;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: SvgPicture.asset(rating_star,colorFilter: ColorFilter.mode(selectedRating > index ? AppColors.primary : Color(0xFFF9A31E),BlendMode.srcIn),height: 30,width: 30,),
                        )
                        );
                      }),
                    ),

                    const SizedBox(height: 16),
                    Divider(height: 2,color: AppColors.primary.withValues(alpha: 0.5),),
                    const SizedBox(height: 8),

                    // Review Text Area
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Add detailed review',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: _reviewController,
                            maxLines: 3,
                            decoration: const InputDecoration(
                              hintText: 'Enter here',
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Add Photo and Re-Order Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.add_a_photo_outlined, color: Colors.grey[700]),
                            const SizedBox(width: 8),
                            Text(
                              'Add Photo',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: ()  async {
                            Get.to(() => ReorderScreen(order: widget.order));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Re-Order',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Buttons
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          final response = await Get.find<OrderController>().rateDelivery(widget.order.deliveryAgent,widget.order.user,_reviewController.text.trim(),widget.order.id, selectedRating);
                          if(response){
                            AppSnackBar.showSuccess(context, message: "Review sent successfully");
                          }else{
                            AppSnackBar.showError(context, message: "Review send failed");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}