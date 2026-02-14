// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:newdow_customer/features/address/controller/addressController.dart';
// import 'package:newdow_customer/features/address/controller/pickDefaultAddressController.dart';
// import 'package:newdow_customer/features/address/model/addressModel.dart';
//
// import '../../../utils/apptheme.dart';
// import '../../../widgets/appbutton.dart';
//
// class PickAddressScreen extends StatelessWidget {
//
//   AddressController addressCon;
//    PickAddressScreen({super.key,required this.addressCon});
//    final defualtAddressCon = Get.find<PickDefaultAddressController>();
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       top: false,
//         child: Scaffold(
//           appBar: AppBar(
//             title: Text("Pick Location"),
//             centerTitle: true,
//           ),
//           bottomNavigationBar: SafeArea(
//             child: Container(
//               decoration: BoxDecoration(
//                 color: const Color(0xFFF9F9F9),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 10,
//                     offset: Offset(0, -2),
//                   ),
//                 ],
//               ),
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               child: Appbutton(
//                 buttonText: "Set as Default",
//                 onTap: () async {
//
//                 }, isLoading: false,
//               ),
//             ),
//           ),
//           body:  Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Obx(() {
//               final selectedAddres = defualtAddressCon.selectedAddress.value?.id;
//               return ListView.separated(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: addressCon.usersAddress.length,
//                   separatorBuilder: (_, __) => const SizedBox(height: 12),
//                   itemBuilder: (context, index) {
//                     final addr = addressCon.usersAddress[index];
//                     final isSelected = selectedAddres == addr.id;
//
//                     return InkWell(
//                       onTap: () => defualtAddressCon.changeAddress(addr),
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 12, vertical: 16),
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: isSelected ? AppColors.primary : Colors.grey
//                                 .shade300,
//                           ),
//                           borderRadius: BorderRadius.circular(12),
//                           color: isSelected
//                               ? AppColors.primary.withOpacity(0.05)
//                               : null,
//                         ),
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 "${addr.street}, ${addr.city}, ${addr.state}",
//                                 style: const TextStyle(color: Colors.black54),
//                               ),
//                             ),
//                             Icon(
//                               isSelected ? Icons.check_circle : Icons
//                                   .radio_button_unchecked,
//                               color: AppColors.primary,
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   }
//             );
//             },
//             ),
//           )));
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:newdow_customer/features/address/controller/addressController.dart';
// import 'package:newdow_customer/features/address/controller/pickDefaultAddressController.dart';
// import 'package:newdow_customer/features/address/model/addressModel.dart';
// import 'package:newdow_customer/features/address/view/use_current_location_screen.dart';
// import 'package:newdow_customer/utils/getSize.dart';
// import 'package:newdow_customer/widgets/appbar.dart';
// import 'package:newdow_customer/widgets/snackBar.dart';
//
// import '../../../utils/apptheme.dart';
// import '../../../widgets/appbutton.dart';
// import 'create_address_screen.dart';
//
// class PickAddressScreen extends StatefulWidget {
//   AddressController addressCon;
//   PickAddressScreen({super.key, required this.addressCon});
//
//   @override
//   State<PickAddressScreen> createState() => _PickAddressScreenState();
// }
//
// class _PickAddressScreenState extends State<PickAddressScreen> {
//   final defualtAddressCon = Get.find<PickDefaultAddressController>();
//   bool isLoading = false;
//
//   Future<void> _setAsDefault() async {
//     final selectedAddress = defualtAddressCon.selectedAddress.value;
//
//     // Validate selection
//     if (selectedAddress == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please select an address')),
//       );
//       return;
//     }
//
//     // Find current default address
//     final currentDefaultAddress = widget.addressCon.usersAddress
//         .firstWhereOrNull((addr) => addr.isDefault == true);
//
//     if (currentDefaultAddress == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('No current default address found')),
//       );
//       return;
//     }
//
//     // If selected address is already default
//     if (selectedAddress.id == currentDefaultAddress.id) {
//       AppSnackBar.show(context, message: "This is already your default address");
//       // ScaffoldMessenger.of(context).showSnackBar(
//       //   const SnackBar(content: Text('This is already your default address')),
//       // );
//       return;
//     }
//
//     setState(() => isLoading = true);
//
//     try {
//       // Call the switchDefaultAddressWithRollback method
//       await widget.addressCon.switchDefaultAddressWithRollback(
//         currentDefaultAddress.id ?? '',
//         selectedAddress.id ?? '',
//       );
//
//       // Update local state
//       defualtAddressCon.changeAddress(selectedAddress);
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Default address updated successfully')),
//       );
//
//       // Optional: Navigate back or refresh
//       // Get.back();
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     } finally {
//       setState(() => isLoading = false);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       top: false,
//       child: Scaffold(
//         bottomNavigationBar: SafeArea(
//           child: Container(
//             height: 0.1.toHeightPercent(),
//             decoration: BoxDecoration(
//               color: const Color(0xFFF9F9F9),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black12,
//                   blurRadius: 10,
//                   offset: const Offset(0, -2),
//                 ),
//               ],
//             ),
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//             child: Appbutton(
//               buttonText: "Set as Default",
//               onTap: () {
//                 if (!isLoading) {
//                   _setAsDefault();
//                 }
//               },
//               isLoading: isLoading,
//             ),
//         ),
//         ),
//         body: CustomScrollView(
//           slivers: [
//             DefaultAppBar(titleText: "Manage Address", isFormBottamNav: false),
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     OutlinedButton.icon(
//                       onPressed: () => Get.to(LocationPickerScreen()),
//                       icon: const Icon(Icons.my_location, color: AppColors.primary),
//                       label: const Text(
//                         "Use my Current Location",
//                         style: TextStyle(color: AppColors.primary,fontSize: 15),
//                       ),
//                       style: OutlinedButton.styleFrom(
//                         minimumSize: const Size.fromHeight(48),
//                         side: const BorderSide(color: AppColors.primary),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//
//                     // Add New Address Button
//                     OutlinedButton.icon(
//                       onPressed: () => Get.to(UpdateAddressScreen(initialAddress: Get.find<AddressController>().defaultAddress.value,)),
//                       icon: const Icon(Icons.add_location_alt_outlined, color: AppColors.primary),
//                       label: const Text(
//                         "Add New Address",
//                         style: TextStyle(color: AppColors.primary,fontSize: 15),
//                       ),
//                       style: OutlinedButton.styleFrom(
//                         minimumSize: const Size.fromHeight(48),
//                         side: const BorderSide(color: AppColors.primary),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//
//                     Row(
//                       children: [
//                         const Text(
//                           "Saved Address",
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//                     Obx(() {
//                       final selectedAddres = defualtAddressCon.selectedAddress.value?.id;
//                       return ListView.separated(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: widget.addressCon.usersAddress.length,
//                         separatorBuilder: (_, __) => const SizedBox(height: 12),
//                         itemBuilder: (context, index) {
//                           final addr = widget.addressCon.usersAddress[index];
//                           final isSelected = selectedAddres == addr.id;
//
//                           return InkWell(
//                             onTap: () => defualtAddressCon.changeAddress(addr),
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 12,
//                                 vertical: 16,
//                               ),
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: selectedAddres == addr.id
//                                       ? AppColors.primary
//                                       : Colors.grey.shade300,
//                                 ),
//                                 borderRadius: BorderRadius.circular(12),
//                                 color: selectedAddres == addr.id
//                                     ? AppColors.primary.withOpacity(0.05)
//                                     : null,
//                               ),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       "${addr.street}, ${addr.city}, ${addr.state}",
//                                       style: const TextStyle(color: Colors.black54),
//                                     ),
//                                   ),
//                                   Icon(
//                                     selectedAddres == addr.id
//                                         ? Icons.check_circle
//                                         : Icons.radio_button_unchecked,
//                                     color: AppColors.primary,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     }),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:newdow_customer/features/address/controller/addressController.dart';
import 'package:newdow_customer/features/address/controller/pickDefaultAddressController.dart';
import 'package:newdow_customer/features/address/model/addressModel.dart';
import 'package:newdow_customer/features/address/view/use_current_location_screen.dart';
import 'package:newdow_customer/features/address/view/widgets/addressSearchBar.dart';
import 'package:newdow_customer/utils/getSize.dart';
import 'package:newdow_customer/widgets/appbar.dart';
import 'package:newdow_customer/widgets/snackBar.dart';
import '../../../utils/apptheme.dart';
import '../../../utils/constants.dart';
import '../../../widgets/appbutton.dart';
import 'create_address_screen.dart';

class PickAddressScreen extends StatefulWidget {
  AddressController addressCon;
  PickAddressScreen({super.key, required this.addressCon});

  @override
  State<PickAddressScreen> createState() => _PickAddressScreenState();
}

class _PickAddressScreenState extends State<PickAddressScreen> {
  final defualtAddressCon = Get.find<PickDefaultAddressController>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Ensure addresses are loaded
    _initializeAddresses();
  }

  Future<void> _initializeAddresses() async {
    // Load addresses if not already loaded
    if (widget.addressCon.usersAddress.isEmpty) {
      await widget.addressCon.loadAddresses();
    }

    // Initialize the default address selection
    defualtAddressCon.initializeWithDefaultAddress();
  }

  // Future<void> _setAsDefault() async {
  //   final selectedAddress = defualtAddressCon.selectedAddress.value;
  //
  //   // Validate selection
  //   if (selectedAddress == null) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Please select an address')),
  //     );
  //     return;
  //   }
  //
  //   // Find current default address
  //   final currentDefaultAddress = widget.addressCon.usersAddress
  //       .firstWhereOrNull((addr) => addr.isDefault == true);
  //   if (currentDefaultAddress == null) {
  //     // ScaffoldMessenger.of(context).showSnackBar(
  //     //   const SnackBar(content: Text('No current default address found')),
  //     // );
  //     // return;
  //     switchAddress(currentDefaultAddress, selectedAddress);
  //   }
  //
  //   // If selected address is already default
  //   if (selectedAddress.id == currentDefaultAddress?.id) {
  //     AppSnackBar.show(context, message: "This is already your default address");
  //     return;
  //   }
  //   switchAddress(currentDefaultAddress, selectedAddress);
  //
  //   setState(() => isLoading = true);
  //
  // }
  Future<void> _setAsDefault() async {
    if (isLoading) return; // prevent double tap

    final selectedAddress = defualtAddressCon.selectedAddress.value;

    if (selectedAddress == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an address')),
      );
      return;
    }

    final currentDefaultAddress = widget.addressCon.usersAddress
        .firstWhereOrNull((addr) => addr.isDefault == true);

    if (selectedAddress.id == currentDefaultAddress?.id) {
      AppSnackBar.show(
        context,
        message: "This is already your default address",
      );
      return;
    }

    setState(() => isLoading = true);

    await switchAddress(currentDefaultAddress, selectedAddress);

    setState(() {
      isLoading = false;
    });
  }

//   Future<void> switchAddress(AddressModel? currentDefaultAddress,AddressModel selectedAddress) async {
//   try {
//     // Call the switchDefaultAddressWithRollback method
//     // await widget.addressCon.switchDefaultAddressWithRollback(
//     //   currentDefaultAddress?.id ?? '',
//     //   selectedAddress.id ?? '',
//     // );
//     await widget.addressCon.switchDefaultAddressWithRollback(
//       oldAddressId: currentDefaultAddress?.id,
//       newAddressId: selectedAddress.id ?? '',
//     );
//
//     // Update local state
//     defualtAddressCon.changeAddress(selectedAddress);
//
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Default address updated successfully')),
//     );
//   } catch (e) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Error: $e')),
//     );
//   } finally {
//     setState(() => isLoading = false);
//   }
// }

  Future<void> switchAddress(
      AddressModel? currentDefaultAddress,
      AddressModel selectedAddress,
      ) async {
    try {
      await widget.addressCon.switchDefaultAddressWithRollback(
        oldAddressId: currentDefaultAddress?.id,
        newAddressId: selectedAddress.id!,
      );

      // 🔥 Update LOCAL LIST (CRITICAL)
      for (final addr in widget.addressCon.usersAddress) {
        addr.isDefault = addr.id == selectedAddress.id;
      }

      defualtAddressCon.changeAddress(selectedAddress);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Default address updated successfully')),
      );
      Get.back();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        bottomNavigationBar: SafeArea(
          child: Container(
            height: 0.1.toHeightPercent(),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9F9),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Appbutton(
            buttonText: "Set as Default",
            onTap: () async {
              final loadingController = Get.find<LoadingController>();
              loadingController.isLoading.value = true;
              await _setAsDefault().timeout(Duration(seconds: 30),onTimeout: () => loadingController.isLoading.value = false);
              loadingController.isLoading.value = false;
            },
          ),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            DefaultAppBar(titleText: "Manage Address", isFormBottamNav: false),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    OutlinedButton.icon(
                      onPressed: () => Get.to(LocationPickerScreen()),
                      icon: const Icon(Icons.my_location, color: AppColors.primary),
                      label: const Text(
                        "Use my Current Location",
                        style: TextStyle(color: AppColors.primary, fontSize: 15),
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
                      onPressed: () => Get.to(AddAddressScreen(initialAddress: Get.find<AddressController>().defaultAddress.value,)),
                      //onPressed: () => Get.to(UpdateAddressScreen(initialAddress: Get.find<AddressController>().defaultAddress.value,)),
                      icon: const Icon(Icons.add_location_alt_outlined, color: AppColors.primary),
                      label: const Text(
                        "Add New Address",
                        style: TextStyle(color: AppColors.primary, fontSize: 15),
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

                    Row(
                      children: [
                        const Text(
                          "Saved Address",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),

                    Obx(() {
                      final selectedAddressId = defualtAddressCon.selectedAddress.value?.id;

                      if (widget.addressCon.usersAddress.isEmpty) {
                        return const Center(
                          child: Text(
                            'No addresses found. Add a new address.',
                            style: TextStyle(color: Colors.grey),
                          ),
                        );
                      }

                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.addressCon.usersAddress.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final addr = widget.addressCon.usersAddress[index];
                          final isSelected = selectedAddressId == addr.id;

                          return InkWell(
                            onTap: () => defualtAddressCon.changeAddress(addr),
                            child: Dismissible(
                              key: Key(addr.id.toString()),
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
                               final data =  await widget.addressCon.deleteAddress(addr.id!);
                               if(data){
                                 AppSnackBar.showSuccess(context, message: "Address deleted");
                               }else{
                                 AppSnackBar.showError(context, message: "Failed to delete address");
                               }

                              },

                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.primary
                                        : Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  color: isSelected
                                      ? AppColors.primary.withOpacity(0.05)
                                      : null,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      title: Text(
                                        "${addr.type}",
                                        style: const TextStyle(color: Colors.black54),
                                      ),
                                      subtitle: Text(
                                        "${addr.street}/${addr.landmark}/${addr.city}/${addr.state}/${addr.country}/${addr.pincode}",
                                          style: const TextStyle(color: Colors.black54),
                                      ),
                                      trailing: Icon(
                                        isSelected
                                            ? Icons.check_circle
                                            : Icons.radio_button_unchecked,
                                        color: AppColors.primary,
                                      ),
                                    )

                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}