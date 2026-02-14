import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newdow_customer/features/cart/model/models/couponModel.dart';
import 'package:newdow_customer/utils/apptheme.dart';
import 'package:newdow_customer/utils/getSize.dart';
import 'package:newdow_customer/widgets/snackBar.dart';

import '../../../../utils/constants.dart';

class CouponCard extends StatelessWidget {
  CouponModel coupon;
  CouponCard({super.key, required this.coupon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.18.toHeightPercent(),
      width: 1.toWidthPercent(),

      child: Stack(
        children: [
          Positioned(
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 16, 0,0),
              height: 0.2.toHeightPercent(),
              width: 1.toWidthPercent(),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300, width: 2)
              ),
              child: Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                        child: Flexible(child: Text( coupon.code?? "",style: TextStyle(fontSize: 18),))),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0),
                      child: Flexible(child: Text(coupon.description?? "",style: TextStyle(fontSize: 15),)),
                    ),Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        children: [
                          SvgPicture.asset(coupon_discout_percent),
                          Expanded(child: Text(coupon.discountValue.toString(),style: TextStyle(fontSize: 15),)),
                        ],
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () => {
                        Clipboard.setData(ClipboardData(text: coupon.code ?? "")),
                        AppSnackBar.showSuccess(context, message: "Coupon code copied")
                      },
                      child: Container(
                        height: 0.03.toHeightPercent(),
                        alignment: Alignment.center,
                        color: Color(0xFFEBEBEB),
                        child: Text("COPY CODE",style: TextStyle(fontSize: 13,color: AppColors.primary),),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              top: 35,
              left: -20.0,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade300, width: 2)
                ),
              )
          ),
          Positioned(
            top: 35,
            right: -20.0,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade300, width: 2)
                ),
              )
          )
        ],
      ),
    );
  }
}
