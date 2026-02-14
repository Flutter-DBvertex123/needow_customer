import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:newdow_customer/features/address/controller/addressController.dart';
import 'package:newdow_customer/features/address/view/pickAddressScreen.dart';
import 'package:newdow_customer/features/home/view/widgets/searchBar.dart';
import 'package:newdow_customer/features/profile/view/my_wallet_screen.dart';
import 'package:newdow_customer/utils/constants.dart';
import 'package:newdow_customer/utils/getSize.dart';
import 'package:newdow_customer/widgets/navbar.dart';
import '../features/profile/view/profile_screen.dart';
import '../utils/apptheme.dart';

class CustomAppBar extends StatelessWidget {
  bool? isFromFoodDashboard;
  bool? isInServiceableArea  = false;
  CustomAppBar({Key? key, this.isFromFoodDashboard,this.isInServiceableArea}) : super(key: key);
  final addressCon = Get.find<AddressController>();
  Widget _buildIconButton(String icon, VoidCallback onTap) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          height: 20,
          width: 20,
          child: SvgPicture.asset(icon),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    print("current Address${addressCon.defaultAddress.value?.landmark }",);
    return  SliverAppBar(
      toolbarHeight: 165,
      collapsedHeight: 165,
      automaticallyImplyLeading: false,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.background, // important for rounded corners
      flexibleSpace: FlexibleSpaceBar(
        background: ClipRRect(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(24), // smooth bottom curve
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.primary,
                  AppColors.primary.withOpacity(0.95),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 60, left: 16, right: 16),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(PickAddressScreen(addressCon: addressCon));
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        isFromFoodDashboard ?? false ?
                        SizedBox(
                          height: 0.05.toHeightPercent(),
                          width: 0.1.toWidthPercent(),
                          child: IconButton(icon: Icon(Icons.arrow_back_ios_new,color: Colors.white,),
                            onPressed: (){
                            Get.back();
                            },
                            iconSize: 18,
                          ),
                        ) : SizedBox(),


                        Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [


                              Obx(() {
                              if (addressCon.defaultAddress.value != null) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: Text(
                                    addressCon.defaultAddress.value!.type,
                                    style: TextStyle(color: Colors.white70, fontSize: 12),
                                  ),
                                );
                              }
                              return Padding(
                                padding: const EdgeInsets.only(left: 25),
                                child: Text(
                                  "Location",
                                  style: TextStyle(color: Colors.white70, fontSize: 12),
                                ),
                              );
                            }),
                            Container(
                              width: 0.6.toWidthPercent(),
                              child: Row(
                                spacing: 6,
                                children: [
                                  SvgPicture.asset(home_location_icon),
                                  Obx(() {
                                    if (addressCon.defaultAddress.value != null) {
                                      return Expanded(
                                        child: Text(
                                          "${addressCon.defaultAddress.value!.street} "
                                              "${addressCon.defaultAddress.value!.city}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      );
                                    }
                                    return Text(
                                      "Address Unavailable",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    );
                                  }),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        _buildIconButton(appbar_wallet_icon, () => Get.to(MyWalletScreen())),
                        SizedBox(width: 12),
                        _buildIconButton(appbar_profile_icon, () => Get.to(ProfileScreen())),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  SearchBarWidget(isServiceable: isInServiceableArea,),
                ],
              ),
            ),

            // child: Padding(
            //   padding: const EdgeInsets.only(top: 60, left: 16, right: 16),
            //   child: FutureBuilder(
            //       future: getAddress(),
            //       builder: (context, asyncSnapshot) {
            //         return Column(
            //           children: [
            //             InkWell(
            //               onTap: (){
            //                 Get.to(PickAddressScreen(addressCon: addressCon));
            //               },
            //               child: Row(
            //                 mainAxisSize: MainAxisSize.min,
            //                 children: [
            //                   Icon(Icons.location_on_outlined, color: Colors.white, size: 25),
            //                   SizedBox(width: 8),
            //                   Column(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     mainAxisSize: MainAxisSize.min,
            //                     children: [
            //                       Obx(() {
            //                         if(addressCon.defaultAddress.value != null){
            //                           return Text(
            //                             '${addressCon.defaultAddress.value!
            //                                 .type}',
            //                             style: TextStyle(
            //                               color: Colors.white70,
            //                               fontSize: 12,
            //                             ),
            //                           );
            //                         }else {
            //                           return Text("Location",style: TextStyle(
            //                             color: Colors.white70,
            //                             fontSize: 12,
            //                           ),);
            //                         }
            //                       }
            //                       ),
            //                       Row(
            //                         children: [
            //                           Obx(() {
            //                             if(addressCon.defaultAddress.value != null) {
            //                               return Text(
            //                                 "${addressCon.defaultAddress.value!
            //                                     .street} ${addressCon
            //                                     .defaultAddress.value!
            //                                     .city}",
            //                                 style: TextStyle(
            //                                   color: Colors.white,
            //                                   fontSize: 14,
            //                                   fontWeight: FontWeight.w600,
            //                                 ),
            //                               );
            //                             }
            //                             else {
            //                               return Text("Address Unavailable",style: TextStyle(
            //                                 color: Colors.white,
            //                                 fontSize: 14,
            //                                 fontWeight: FontWeight.w600,
            //                               ),);
            //                             }
            //                           }
            //                           ),
            //                           Icon(Icons.keyboard_arrow_down,
            //                             color: Colors.white,
            //                             size: 20,
            //                           ),
            //                         ],
            //                       ),
            //                     ],
            //                   ),
            //
            //                   Spacer(),
            //                   _buildIconButton(appbar_wallet_icon, () => Get.to(MyWalletScreen())),
            //                   SizedBox(width: 12),
            //                   _buildIconButton(appbar_profile_icon, () => Get.to(ProfileScreen())),
            //                 ],
            //               ),
            //             ),
            //             SizedBox(height: 16),
            //             SearchBarWidget()
            //           ],
            //         );
            //       }
            //   ),
            // ),
          ),
        ),
      ),
    );

  }
  Future<void> getAddress() async {
    await addressCon.loadAddresses();
  }
}
class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  String titleText;
  String? subtitleText;
  Widget? trailing;
  bool isFormBottamNav;
  DefaultAppBar({super.key,required this.titleText,this.subtitleText, this.trailing,required this.isFormBottamNav});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leadingWidth: 75,
      toolbarHeight: 0.07.toHeightPercent(),
      surfaceTintColor: AppColors.background,

      title: Column(
        children: [
          Text(titleText,style: TextStyle(fontSize: 22),),
          subtitleText != null ? Text(subtitleText!,style: TextStyle(color: AppColors.textSecondary,fontSize: 15),) : SizedBox(),
        ],
      ),
      leading: isFormBottamNav ? SizedBox() : Padding(
        padding: EdgeInsets.only(left: 16),
        child: IconButton(
          //onPressed: ()  => isFormBottamNav ? Get.to(CustomBottomNav(currentIndex: 0,)) : Navigator.pop(context),
          onPressed: ()  =>  Navigator.pop(context),
          icon: CircleAvatar(
            backgroundColor: AppColors.secondary,
            radius: 30,
            child: Icon(
              Icons.arrow_back_sharp,
              color: AppColors.primary,
              size: 25,
              weight: 800,
            ),
          ),
        ),
      ),


      // Provide a standard title.
      actions: [
        ?trailing != null ? Padding(padding: EdgeInsets.only(right: 16),child: trailing) : SizedBox(height: 48,width: 48,),
      ],
      centerTitle: true,
      // Pin the app bar when scrolling.
      pinned: true,
      // Display a placeholder widget to visualize the shrinking size.
      // Make the initial height of the SliverAppBar larger than normal.
      collapsedHeight: 0.07.toHeightPercent(),
    );
    //padding: const EdgeInsets.symmetric(vertical: 18),
    // return Column(
    //   children: [
    //     SizedBox(height: 0.04.toHeightPercent(),),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         IconButton(
    //             onPressed: () => Navigator.pop(context),
    //             icon: CircleAvatar(
    //               backgroundColor: Theme.of(context).colorScheme.secondary,
    //               radius: 20,
    //                 child: Icon(Icons.arrow_back_sharp,color: Colors.green,size: 25,weight: 800,))),
    //         Column(
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //           children: [
    //             Text(titleText,style: TextStyle(fontSize: 22),),
    //             subtitleText != null ? Text(subtitleText!,style: TextStyle(color: AppColors.secondaryText,fontSize: 15),) : SizedBox(),
    //           ]
    //         ),
    //         ?trailing != null ? trailing : SizedBox(height: 48,width: 48,),
    //
    //       ],
    //     //   spacing: 10,
    //     //   children: [
    //     // CircleAvatar(
    //     // radius: 35,
    //     //       backgroundColor: Colors.grey,
    //     //       child: Image.asset("assets/pngs/user_avatar.png",)
    //     //       ),
    //     //       Column(
    //     //         crossAxisAlignment: CrossAxisAlignment.start,
    //     //         children: [
    //     // Text("Name"),
    //     // Text("smau@gmailcom"),
    //     //         ],
    //     //       ),
    //     //
    //     //   ],
    //     )
    //
    //   ],

  }
}
