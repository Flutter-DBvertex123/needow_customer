import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:newdow_customer/features/profile/view/widgets/Coupon_widget.dart';
import 'package:newdow_customer/utils/getSize.dart';
import 'package:newdow_customer/widgets/appbar.dart';

import '../../cart/controller/cupoonController.dart';
import '../../cart/model/models/couponModel.dart';

class CouponSceen extends StatelessWidget {
  bool isFromBottamNav;
   CouponSceen({super.key,required this.isFromBottamNav});
   final couponController = Get.find<CouponController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          top: false,
          child: CustomScrollView(
            physics: NeverScrollableScrollPhysics(),
        slivers: [
          DefaultAppBar(titleText: "Coupons",isFormBottamNav: isFromBottamNav,),
          SliverToBoxAdapter(
            child: Padding(
              padding:  EdgeInsets.only(left: 16.0,bottom: 16,right: 16,top: 8),
              child: FutureBuilder<List<CouponModel>>(
                future: couponController.getCoupons(),
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (asyncSnapshot.hasError) {
                    return Center(child: Text("Error: ${asyncSnapshot.error}"));
                  }
                  if (!asyncSnapshot.hasData || asyncSnapshot.data!.isEmpty) {
                    return Center(child: Text("No products found"));
                  }
                  final coupons = asyncSnapshot.data;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Best Offers for you",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: isFromBottamNav? kBottomNavigationBarHeight: 8),
                        height: 0.75.toHeightPercent(),
                        width: 1.toWidthPercent(),
                        child: ListView.separated(
                            itemBuilder: (context,index) => CouponCard(coupon: coupons![index],),
                            separatorBuilder: (_, __) => SizedBox(height: 8),
                            itemCount: coupons!.length),
                      )
                  ]
                              );
                }
              ),
          ),
      ),
          ]
          ) ),
    );
  }
}
