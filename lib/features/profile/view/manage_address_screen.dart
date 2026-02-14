import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:newdow_customer/features/address/view/create_address_screen.dart';
import 'package:newdow_customer/features/address/view/use_current_location_screen.dart';
import 'package:newdow_customer/utils/getSize.dart';
import 'package:newdow_customer/widgets/appbar.dart';

import '../../../utils/apptheme.dart';
import '../../../utils/constants.dart';
import '../../../widgets/snackBar.dart';
import '../../address/controller/addressController.dart';

class ManageAddressScreen extends StatelessWidget {
  bool? isFromCheckOutScreen;
  ManageAddressScreen({super.key,this.isFromCheckOutScreen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          physics: NeverScrollableScrollPhysics(),
          slivers: [
            DefaultAppBar(titleText: "Manage Address",isFormBottamNav: false,),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search bar
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: TextStyle(color: AppColors.textSecondary),
                        prefixIcon: Icon(Icons.search,size: 28,color: AppColors.textSecondary,),
                        filled: true,
                        fillColor: Color(0xFFEBEBEB),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    //Use Current Location Button
                    OutlinedButton.icon(
                      onPressed: () => (isFromCheckOutScreen != null && isFromCheckOutScreen!) ?  Get.off(LocationPickerScreen()) : Get.to(LocationPickerScreen()),
                      icon: const Icon(Icons.my_location, color: AppColors.primary),
                      label: const Text(
                        "Use my Current Location",
                        style: TextStyle(color: AppColors.primary,fontSize: 15),
                      ),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                        side: const BorderSide(color: AppColors.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Add New Address Button
                    OutlinedButton.icon(
                      onPressed: () => (isFromCheckOutScreen != null && isFromCheckOutScreen!) ? Get.off(AddAddressScreen(initialAddress: Get.find<AddressController>().defaultAddress.value,)) : Get.to(AddAddressScreen(initialAddress: Get.find<AddressController>().defaultAddress.value,)),
                      icon: const Icon(Icons.add_location_alt_outlined, color: AppColors.primary),
                      label: const Text(
                        "Add New Address",
                        style: TextStyle(color: AppColors.primary,fontSize: 15),
                      ),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                        side: const BorderSide(color: AppColors.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      "Saved Address",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),


                    // Address List
                    Obx(() {
                      final addressCon = Get.find<AddressController>();
                      return Container(
                        height: 0.54.toHeightPercent(),
                        child: ListView.separated(

                          itemCount: addressCon.usersAddress.length,
                          itemBuilder: (context, index) {
                            final address = addressCon.usersAddress[index];
                            return Dismissible(
                              key: Key(address.id.toString()),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.secondary,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: SvgPicture.asset(delete_icon),
                              ),
                              onDismissed: (direction) async {
                                final data =  await addressCon.deleteAddress(address.id!);
                                if(data){
                                  AppSnackBar.showSuccess(context, message: "Address deleted");
                                }else{
                                  AppSnackBar.showError(context, message: "Failed to delete address");
                                }

                              },
                              child: AddressTile(
                                title: address.type,
                                address:
                                "${address.street}/${address.landmark}/${address.city}/${address.state}/${address.country}/PIN ${address.pincode}",
                                icon: Icon(address.type == "home"? Icons.home_outlined : Icons.business_outlined,
                                    color: AppColors.primary),
                              ),
                            );
                          }, separatorBuilder: (BuildContext context, int index) {return SizedBox(height: 12,);},

                        ),
                      );
                    }
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AddressTile extends StatelessWidget {
  final String title;
  final String address;
  final Icon icon;

  const AddressTile({
    super.key,
    required this.title,
    required this.address,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: AppColors.primary
                    ),
                  ),

                  Text(
                    address,
                    style: TextStyle(color: AppColors.textSecondary,fontSize: 12),
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
