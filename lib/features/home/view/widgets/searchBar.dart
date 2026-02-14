//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:newdow_customer/features/notification/view/notification_screen.dart';
// import 'package:newdow_customer/utils/getSize.dart';
//
// import '../../../../utils/apptheme.dart';
// import '../../../../utils/constants.dart';
// import '../../../browseProducts/controller/searchController.dart';
//
// class SearchBarWidget extends StatelessWidget {
//    SearchBarWidget({Key? key}) : super(key: key);
// final searchController = Get.find<ProductSearchController>();
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(4, 0, 4, 16),
//       child: Container(
//         height: 48,
//         decoration: BoxDecoration(
//           color: Colors.transparent,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Row(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(topLeft: Radius.circular(12),bottomLeft: Radius.circular(12))
//               ),
//               height: 48,
//               padding: const EdgeInsets.only(left: 12),
//               child: Icon(Icons.search, color: Colors.grey[400], size: 22),
//             ),
//                Container(
//                 width: 0.68.toWidthPercent(),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(topRight: Radius.circular(12),bottomRight: Radius.circular(12))
//                 ),
//                 child: TextField(
//                   onChanged: (value) => searchController.onSearchChanged(value),
//                   decoration: InputDecoration(
//                     hintText: 'Search for products',
//                     hintStyle: TextStyle(
//                       color: Colors.grey[400],
//                       fontSize: 14,
//                     ),
//                     fillColor: Colors.white,
//                     border: InputBorder.none,
//                   ),
//                 ),
//               ),
//
//             Expanded(
//                 child: Container(
//                   color: AppColors.primary,
//                 )),
//             Container(
//               color: AppColors.primary,
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 0),
//                 child: _buildIconButton(nav_noti, () => Get.to(NotificationScreen())),
//               ),
//             )
//
//           ],
//         ),
//       ),
//     );
//   }
//   Widget _buildIconButton(String icon, VoidCallback onTap) {
//     return Container(
//       width: 0.105.toWidthPercent(),
//       height: 48,
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: InkWell(
//         onTap: onTap,
//         child: Container(
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           height: 20,
//           width: 20,
//           child: SvgPicture.asset(notificatons),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:newdow_customer/features/home/controller/buisnessController.dart';
import 'package:newdow_customer/features/notification/view/notification_screen.dart';
import 'package:newdow_customer/utils/getSize.dart';
import '../../../../utils/apptheme.dart';
import '../../../../utils/constants.dart';
import '../../../address/controller/addressController.dart';
import '../../../browseProducts/controller/searchController.dart';

class SearchBarWidget extends StatefulWidget {
  final bool? isServiceable;
  SearchBarWidget({Key? key,this.isServiceable}) : super(key: key);

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final searchController = Get.find<ProductSearchController>();
  final addressCon = Get.find<AddressController>();
  final businessCtrl = Get.find<BusinessController>();



  final FocusNode searchFocusNode = FocusNode();

  final TextEditingController searchTextController = TextEditingController();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchFocusNode.unfocus();
    });

    searchFocusNode.addListener(() {
      searchController.isFocused.value = searchFocusNode.hasFocus;
      final userCity = addressCon.defaultAddress.value?.city;
      final hasServiceInCity = userCity != null &&
          businessCtrl.businessTypes.any(
                (b) => b.cities.contains(userCity),
          );
    });
  }
  @override
  void dispose() {
    searchFocusNode.unfocus();
    searchFocusNode.dispose();
    searchTextController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(4, 0, 0, 16),
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
              height: 48,
              padding: const EdgeInsets.only(left: 12),
              child: Icon(Icons.search, color: AppColors.textSecondary, size: 30),
            ),
            Container(
              width: 0.67.toWidthPercent(),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
                child: Obx(() {
                  bool showSuffix = searchController.isFocused.value &&
                      searchController.searchQuery.value.isNotEmpty;

                  return TextField(
                    readOnly: widget.isServiceable != true,
                    focusNode: searchFocusNode,
                    controller: searchTextController,
                    onChanged: (value) {
                      searchController.onSearchChanged(value);
                      searchController.searchQuery.value = value;   // IMPORTANT
                    },
                    decoration: InputDecoration(
                      hintText: 'Search for products',
                      //labelText: 'Search for products',
                      //isDense: false,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      hintStyle: TextStyle(color: AppColors.textSecondary),
                      suffixIcon: (searchController.isFocused.value ||
                          searchController.searchQuery.value.isNotEmpty)
                          ? IconButton(
                        onPressed: () {
                          searchTextController.clear();
                          searchController.clearSearch();

                          searchFocusNode.unfocus();   // <- Better than FocusScope
                          FocusScope.of(context).requestFocus(FocusNode());
                        },

                        icon: Icon(
                          Icons.cancel_outlined,
                          color: AppColors.primary,
                          //size: 18,
                        ),
                      )
                          : null,
                      border: InputBorder.none,
                    ),
                  );

                })


            ),
            Expanded(child: Container(color: AppColors.primary)),
            Container(
              color: AppColors.primary,
              child: Padding(
                padding: const EdgeInsets.only(left: 0),
                child: _buildIconButton(nav_noti, () => Get.to(NotificationScreen())),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(String icon, VoidCallback onTap) {
    return Container(
      //width: 0.105.toWidthPercent(),
      width: 38,
      height: 45,
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
            borderRadius: BorderRadius.circular(10),
          ),
          child: SvgPicture.asset(notificatons),
        ),
      ),
    );
  }
}
