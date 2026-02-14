import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:newdow_customer/features/auth/view/login_screen.dart';
import 'package:newdow_customer/features/profile/view/coupon_sceen.dart';
import 'package:newdow_customer/features/orders/view/my_orders_screen.dart';
import 'package:newdow_customer/features/profile/view/my_wallet_screen.dart';
import 'package:newdow_customer/features/profile/view/payment_methods_screen.dart';
import 'package:newdow_customer/features/profile/view/privacy_policy_screen.dart';
import 'package:newdow_customer/features/profile/view/view_profile_screen.dart';
import 'package:newdow_customer/utils/apptheme.dart';
import 'package:newdow_customer/utils/constants.dart';
import 'package:newdow_customer/utils/getSize.dart';
import 'package:newdow_customer/utils/prefs.dart';
import 'package:newdow_customer/widgets/appbar.dart';
import 'package:newdow_customer/widgets/appbutton.dart';

import '../../../widgets/profile_picture.dart';
import '../../address/controller/addressController.dart';
import '../controller/profile_controller.dart';
import 'manage_address_screen.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController profileCon = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    profileCon.getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            DefaultAppBar(titleText: "Profile",isFormBottamNav: false,),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Obx(() => ProfileAvatar(imageUrl: profileCon.savedData.value?.photo ?? "")),
                      // Obx(() => CircleAvatar(
                      //   radius: 64,
                      //   backgroundImage: NetworkImage(profileCon.savedData.value?.photo ?? ""),
                      // ),
                      // ),
                      // Positioned(
                      //   bottom: 0,
                      //   right: 0,
                      //   child: CircleAvatar(
                      //     radius: 20,
                      //     backgroundColor: AppColors.primary,
                      //     child: SvgPicture.asset(edit_pic),
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: 0.018.toHeightPercent()),
                  Obx(
                    () => Text(
                      "${profileCon.savedData.value?.name}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    height: 0.7.toHeightPercent(),
                    width: 1.toHeightPercent(),
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        ListTile(
                          onTap: () => Get.to(ViewProfileScreen()),
                          minTileHeight: 0.08.toHeightPercent(),
                          leading: SvgPicture.asset(profile_icon),
                          title: Text("Your Profile"),
                          trailing: Icon(Icons.navigate_next,size: 30,),
                        ),
                        Divider(height: 1, color: Color(0x807BC3A8)),
                        ListTile(
                          onTap: () => Get.to(ManageAddressScreen()),
                          minTileHeight: 0.08.toHeightPercent(),
                          leading: SvgPicture.asset(location_icon),
                          title: Text("Manage Address"),
                          trailing: Icon(Icons.navigate_next,size: 30,),
                        ),
                        Divider(height: 1, color: Color(0x807BC3A8)),
                        ListTile(
                          onTap: () => Get.to(PaymentMethodsScreen()),
                          minTileHeight: 0.08.toHeightPercent(),
                          leading: SvgPicture.asset(payment_method_icon),
                          title: Text("Payment Methods"),
                          trailing: Icon(Icons.navigate_next,size: 30,),
                        ),
                        Divider(height: 1, color: Color(0x807BC3A8)),
                        ListTile(
                          onTap: () => Get.to(MyOrdersScreen(isFormBottamNav: false,)),
                          minTileHeight: 0.08.toHeightPercent(),
                          leading: SvgPicture.asset(myorders),
                          title: Text("My Orders"),
                          trailing: Icon(Icons.navigate_next,size: 30,),
                        ),
                        Divider(height: 1, color: Color(0x807BC3A8)),
                        ListTile(
                          onTap: () => Get.to(CouponSceen(isFromBottamNav: false,)),
                          minTileHeight: 0.08.toHeightPercent(),
                          leading: SvgPicture.asset(mycoupans),
                          title: Text("My Coupons"),
                          trailing: Icon(Icons.navigate_next,size: 30,),
                        ),
                        Divider(height: 1, color: Color(0x807BC3A8)),
                        ListTile(
                          onTap: () => Get.to(MyWalletScreen()),
                          minTileHeight: 0.08.toHeightPercent(),
                          leading: SvgPicture.asset(myWallet),
                          title: Text("My Wallet"),
                          trailing: Icon(Icons.navigate_next,size: 30,),
                        ),
                        Divider(height: 1, color: Color(0x807BC3A8)),
                        ListTile(
                          onTap: () => Get.to(PrivacyPolicyScreen()),
                          minTileHeight: 0.08.toHeightPercent(),
                          leading: SvgPicture.asset(policyIcon,height: 24,color: AppColors.primary,),
                          title: Text("Privacy and Policy"),
                          trailing: Icon(Icons.navigate_next,size: 30,),
                        ),
                        Divider(height: 1, color: Color(0x807BC3A8)),
                        ListTile(
                          onTap: () {
                            showLogoutBottomSheet(context);
                          },
                          minTileHeight: 0.08.toHeightPercent(),
                          leading: SvgPicture.asset(logoutIcon),
                          title: Text("Logout"),
                          trailing: Icon(Icons.navigate_next,size: 30,),
                        ),
                        Divider(height: 1, color: Color(0x807BC3A8)),
                      ],
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

  void showLogoutBottomSheet(BuildContext context) {
    final addressCon = Get.find<AddressController>();
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Container(
            height: 0.22.toHeightPercent(),
            margin: EdgeInsets.fromLTRB(20, 8, 20, 12),
            width: 1.toWidthPercent(),
            child: Column(
              spacing: 12,
              children: [
                SizedBox(height: 0.02.toHeightPercent()),
                Text("Logout", style: TextStyle(fontSize: 20)),
                Divider(height: 1,color: AppColors.primary.withOpacity(0.5),),
                Text(
                  "Are you sure you want to Logout",
                  style: TextStyle(fontSize: 20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 45,
                        alignment: Alignment.center,
                        constraints: BoxConstraints(
                          minWidth: 0.42.toWidthPercent(),
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(27),
                        ),
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: AppColors.primary, fontSize: 18),
                        ),
                      ),
                    ),InkWell(
                      onTap: () async {
                        await Get.find<ProfileController>().logout();
                      },

                      child: Container(
                        height: 45,
                        alignment: Alignment.center,
                        constraints: BoxConstraints(
                          minWidth: 0.42.toWidthPercent(),
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xff0A9962),
                          borderRadius: BorderRadius.circular(27),
                        ),
                        child: Text(
                          "Yes, Logout",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
