// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:newdow_customer/utils/apptheme.dart';
// import 'package:newdow_customer/utils/getSize.dart';
// import 'package:newdow_customer/utils/prefs.dart';
// import 'package:newdow_customer/widgets/appbar.dart';
// import 'package:newdow_customer/widgets/snackBar.dart';
// import '../../../utils/constants.dart';
// import '../controller/wallet_controller.dart';
//
// class MyWalletScreen extends StatefulWidget {
//   const MyWalletScreen({super.key});
//
//   @override
//   State<MyWalletScreen> createState() => _MyWalletScreenState();
// }
//
// class _MyWalletScreenState extends State<MyWalletScreen> {
//   final WalletController controller = Get.find<WalletController>();
//
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     controller.fetchWalletData(refresh: true);
//   }
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       body: SafeArea(
//         top: false,
//         child: Obx(() {
//           final isLoading = controller.isLoading.value;
//           final transactions = controller.transactions;
//
//           // REAL BALANCE FROM /balance API
//           final currentBalance = controller.currentBalance.value;
//
//           return RefreshIndicator(
//             onRefresh: controller.onRefresh,
//             child: CustomScrollView(
//               physics: const AlwaysScrollableScrollPhysics(),
//               slivers: [
//                  DefaultAppBar(
//                   titleText: "My Wallet",
//                   isFormBottamNav: false,
//                 ),
//                 SliverToBoxAdapter(
//                   child: Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       children: [
//                         // === WALLET BALANCE CARD ===
//                         Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//                           height: 0.17.toHeightPercent(),
//                           width: 1.toWidthPercent(),
//                           decoration: BoxDecoration(
//                             color: AppColors.primary.withOpacity(0.5),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Column(
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       const Text("Wallet Balance", style: TextStyle(fontSize: 15)),
//                                       // REAL BALANCE FROM API
//                                       Text(
//                                         "₹ ${currentBalance.toStringAsFixed(2)}",
//                                         style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                                       ),
//                                     ],
//                                   ),
//                                   Container(
//                                     width: 36,
//                                     height: 36,
//                                     decoration: BoxDecoration(
//                                       color: Colors.white.withOpacity(0.2),
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                     child: InkWell(
//                                       onTap: () {},
//                                       child: Container(
//                                         alignment: Alignment.center,
//                                         decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius: BorderRadius.circular(8),
//                                         ),
//                                         height: 20,
//                                         width: 20,
//                                         child: SvgPicture.asset(appbar_wallet_icon),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const Spacer(),
//                               InkWell(
//                                 onTap: () async {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(content: Text('Add Money Clicked')),
//
//                                   );
//                                   showDepositWalletDialog(context, userId: await AuthStorage.getUserFromPrefs().then((user) => user?.id ?? ""),
//                                       onDeposit: (userId, amount, description) async{
//                                     final response = await controller.addMoney(userId: userId,amount: amount,description: description);
//                                     if(response){
//                                       controller.fetchWalletData(refresh: true);
//                                     }else{
//                                       AppSnackBar.showError(context, message: "Failed to Deposit Amount");
//                                     }
//                                   });
//                                 },
//                                 child: Container(
//                                   alignment: Alignment.center,
//                                   height: 56,
//                                   width: 1.toWidthPercent(),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(12),
//                                     color: AppColors.primary,
//                                   ),
//                                   child: const Text(
//                                     "Add Money",
//                                     style: TextStyle(color: Colors.white, fontSize: 18),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//
//                         const SizedBox(height: 24), // Clean gap
//
//                         // === TRANSACTION LIST ===
//                         SizedBox(
//                           height: 0.78.toHeightPercent(),
//                           child: isLoading && transactions.isEmpty
//                               ? const Center(child: CircularProgressIndicator())
//                               : transactions.isEmpty
//                               ? Center(
//                             child: Text(
//                               "No transactions yet",
//                               style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//                             ),
//                           )
//                               : ListView.separated(
//                             physics: const NeverScrollableScrollPhysics(),
//                             itemCount: controller.groupKeys.length,
//                             separatorBuilder: (context, index) => const SizedBox(height: 20),
//                             itemBuilder: (context, groupIndex) {
//                               final group = controller.groupKeys[groupIndex];
//                               final items = controller.groupedTransactions[group]!;
//
//                               return Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   // Group Header
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
//                                     child: Text(
//                                       group,
//                                       style: const TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 15,
//                                         color: Colors.black87,
//                                       ),
//                                     ),
//                                   ),
//
//                                   // Group Items
//                                   ...items.map((tx) => Container(
//                                     margin: const EdgeInsets.only(bottom: 12),
//                                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//                                     decoration: BoxDecoration(
//                                       color: AppColors.secondary,
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Expanded(
//                                               child: Text(
//                                                 tx.description,
//                                                 style: const TextStyle(fontSize: 16),
//                                                 overflow: TextOverflow.ellipsis,
//                                               ),
//                                             ),
//                                             Text(
//                                               controller.formatAmount(tx.amount, tx.type),
//                                               style: TextStyle(
//                                                 color: tx.type == "WITHDRAW"
//                                                     ? Colors.red
//                                                     : Colors.green,
//                                                 fontSize: 15,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         const SizedBox(height: 6),
//                                         Text(
//                                           "${DateFormat('dd MMMM yyyy').format(tx.createdAt.toLocal())} | ${controller.formatTime(tx.createdAt)}",
//                                           style: TextStyle(
//                                             color: Colors.black.withOpacity(0.7),
//                                             fontSize: 13,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   )),
//
//                                   const SizedBox(height: 8),
//                                 ],
//                               );
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }),
//       ),
//     );
//   }
//   void showDepositWalletDialog(
//       BuildContext context, {
//         required String userId,
//         required Function(String, double, String) onDeposit,
//       }) {
//     final TextEditingController amountController = TextEditingController();
//     final TextEditingController descriptionController = TextEditingController();
//     final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           title: const Text(
//             'Deposit to Wallet',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           content: SingleChildScrollView(
//             child: Form(
//               key: formKey,
//               child: Column(
//
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // User ID Display
//                   SizedBox(width: 0.8.toWidthPercent(),),
//
//
//                   // Amount Input Field
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 16),
//                     child: TextFormField(
//                       controller: amountController,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         labelText: 'Amount',
//                         hintText: 'Enter amount',
//                         prefixIcon: const Icon(Icons.currency_rupee,color: AppColors.primary,),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide(color: Colors.grey[300]!),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: const BorderSide(color: Colors.blue),
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter an amount';
//                         }
//                         if (double.tryParse(value) == null) {
//                           return 'Please enter a valid amount';
//                         }
//                         if (double.parse(value) <= 0) {
//                           return 'Amount must be greater than 0';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//
//                   // Description Input Field
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 16),
//                     child: TextFormField(
//                       controller: descriptionController,
//                       maxLines: 3,
//                       decoration: InputDecoration(
//                         labelText: 'Description',
//                         hintText: 'e.g., Top-up bonus',
//                         prefixIcon: const Icon(Icons.description,color: AppColors.primary,),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide(color: Colors.grey[300]!),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: const BorderSide(color: Colors.blue),
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter a description';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           actions: [
//             // Cancel Button
//             TextButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.secondary,
//                 padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               onPressed: () {
//                 amountController.dispose();
//                 descriptionController.dispose();
//                 Navigator.of(context).pop();
//               },
//               child: const Text(
//                 'Cancel',
//                 style: TextStyle(color: Colors.grey),
//               ),
//             ),
//
//             // Deposit Button
//             ElevatedButton(
//
//               onPressed: () {
//                 if (formKey.currentState!.validate()) {
//                   final amount = double.parse(amountController.text);
//                   final description = descriptionController.text.trim();
//
//                   // Call the callback function with the data
//                   onDeposit(userId, amount, description);
//
//                   // Close the dialog
//                   Navigator.of(context).pop();
//
//                   // Dispose controllers
//                   amountController.dispose();
//                   descriptionController.dispose();
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.primary,
//                 padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               child: const Text(
//                 'Deposit',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
// // Usage Example in a Widget
//
// }
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:newdow_customer/features/payment/controller/paymentController.dart';
import 'package:newdow_customer/features/profile/model/wallet_model.dart';
import 'package:newdow_customer/features/profile/view/widgets/trasectionListShimmer.dart';
import 'package:newdow_customer/utils/apptheme.dart';
import 'package:newdow_customer/utils/getSize.dart';
import 'package:newdow_customer/utils/prefs.dart';
import 'package:newdow_customer/widgets/appbar.dart';
import 'package:newdow_customer/widgets/snackBar.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../utils/constants.dart';
import '../../cart/view/payment_success_screen.dart';
import '../../orders/controllers/orderController.dart';
import '../../payment/paymentServices/makePaymentService.dart';
import '../controller/wallet_controller.dart';

class MyWalletScreen extends StatefulWidget {
  const MyWalletScreen({super.key});

  @override
  State<MyWalletScreen> createState() => _MyWalletScreenState();
}

class _MyWalletScreenState extends State<MyWalletScreen> {
  final WalletController controller = Get.find<WalletController>();


  @override
  void initState() {
    super.initState();
    getWallet();
  }
Future<void> getWallet() async {
    print("calling wallet");
  await controller.fetchWalletData(refresh: true);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Obx(() {
          final isLoading = controller.isLoading.value;
          final transactions = controller.transactions;
          final currentBalance = controller.currentBalance.value;

          return RefreshIndicator(
            onRefresh: controller.onRefresh,
            // child: CustomScrollView(
            //   physics: const AlwaysScrollableScrollPhysics(),
            //   slivers: [
            //     DefaultAppBar(
            //       titleText: "My Wallet",
            //       isFormBottamNav: false,
            //     ),
            //     SliverToBoxAdapter(
            //       child: Padding(
            //         padding: const EdgeInsets.all(16),
            //         child: Column(
            //           children: [
            //             // === WALLET BALANCE CARD ===
            //             Container(
            //               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            //               height: 0.17.toHeightPercent(),
            //               width: 1.toWidthPercent(),
            //               decoration: BoxDecoration(
            //                 color: AppColors.primary.withOpacity(0.5),
            //                 borderRadius: BorderRadius.circular(12),
            //               ),
            //               child: Column(
            //                 children: [
            //                   Row(
            //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                     children: [
            //                       Column(
            //                         crossAxisAlignment: CrossAxisAlignment.start,
            //                         children: [
            //                           const Text("Wallet Balance", style: TextStyle(fontSize: 15)),
            //                           Text(
            //                             "₹ ${currentBalance.toStringAsFixed(2)}",
            //                             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            //                           ),
            //                         ],
            //                       ),
            //                       Container(
            //                         width: 36,
            //                         height: 36,
            //                         decoration: BoxDecoration(
            //                           color: Colors.white.withOpacity(0.2),
            //                           borderRadius: BorderRadius.circular(8),
            //                         ),
            //                         child: InkWell(
            //                           onTap: () {},
            //                           child: Container(
            //                             alignment: Alignment.center,
            //                             decoration: BoxDecoration(
            //                               color: Colors.white,
            //                               borderRadius: BorderRadius.circular(8),
            //                             ),
            //                             height: 20,
            //                             width: 20,
            //                             child: SvgPicture.asset(appbar_wallet_icon),
            //                           ),
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                   const Spacer(),
            //                   InkWell(
            //                     onTap: () async {
            //                       final user = await AuthStorage.getUserFromPrefs();
            //                       final userId = user?.id ?? "";
            //                       if (userId.isEmpty) {
            //                         AppSnackBar.showError(context, message: "User not found");
            //                         return;
            //                       }
            //                       if(controller.isWalletAvailable.value ){
            //                         _showDepositWalletDialog(context, userId: userId);
            //                       }else{
            //                         controller.createWallet();
            //                       }
            //
            //
            //
            //
            //                     },
            //                     child: Container(
            //                       alignment: Alignment.center,
            //                       height: 56,
            //                       width: 1.toWidthPercent(),
            //                       decoration: BoxDecoration(
            //                         borderRadius: BorderRadius.circular(12),
            //                         color: AppColors.primary,
            //                       ),
            //                       // child:  Text(
            //                       //   "Add Money",
            //                       //   style: TextStyle(color: Colors.white, fontSize: 18),
            //                       // ),
            //                       child: Obx(() {
            //                           if (!controller.isWalletAvailable.value) {
            //                             return const Center(
            //                               child: Text(
            //                                 "Create Wallet",
            //                                 style: TextStyle(color: Colors.white, fontSize: 18),
            //                               ),
            //                             );
            //                           }else{
            //                             return Text(
            //                                 "Add Money",
            //                                 style: TextStyle(color: Colors.white, fontSize: 18),
            //                               );
            //                           }
            //
            //                           ; // your original UI
            //                         })
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //
            //
            //             // === TRANSACTION LIST ===
            //             SizedBox(
            //               height: 0.78.toHeightPercent(),
            //               child: isLoading && transactions.isEmpty
            //                   ? const TransactionShimmer()
            //                   : transactions.isEmpty
            //                   ? Center(
            //                 child: Text(
            //                   "No transactions yet",
            //                   style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            //                 ),
            //               )
            //                   : ListView.separated(
            //                 physics: const NeverScrollableScrollPhysics(),
            //                 itemCount: controller.groupKeys.length,
            //                 separatorBuilder: (context, index) => const SizedBox(height: 20),
            //                 itemBuilder: (context, groupIndex) {
            //                   final group = controller.groupKeys[groupIndex];
            //                   final items = controller.groupedTransactions[group]!;
            //
            //                   return Column(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       Padding(
            //                         padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            //                         child: Text(
            //                           group,
            //                           style: const TextStyle(
            //                             fontWeight: FontWeight.bold,
            //                             fontSize: 15,
            //                             color: Colors.black87,
            //                           ),
            //                         ),
            //                       ),
            //                       ...items.map((tx) => Container(
            //                         margin: const EdgeInsets.only(bottom: 12),
            //                         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            //                         decoration: BoxDecoration(
            //                           color: AppColors.secondary,
            //                           borderRadius: BorderRadius.circular(12),
            //                         ),
            //                         child: Column(
            //                           crossAxisAlignment: CrossAxisAlignment.start,
            //                           children: [
            //                             Row(
            //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                               children: [
            //                                 Expanded(
            //                                   child: Text(
            //                                     tx.description,
            //                                     style: const TextStyle(fontSize: 16),
            //                                     overflow: TextOverflow.ellipsis,
            //                                   ),
            //                                 ),
            //                                 Text(
            //                                   controller.formatAmount(tx.amount, tx.type),
            //                                   style: TextStyle(
            //                                     color: tx.type == "WITHDRAW"
            //                                         ? Colors.red
            //                                         : Colors.green,
            //                                     fontSize: 15,
            //                                     fontWeight: FontWeight.bold,
            //                                   ),
            //                                 ),
            //                               ],
            //                             ),
            //                             const SizedBox(height: 6),
            //                             Text(
            //                               "${DateFormat('dd MMMM yyyy').format(tx.createdAt.toLocal())} | ${controller.formatTime(tx.createdAt)}",
            //                               style: TextStyle(
            //                                 color: Colors.black.withOpacity(0.7),
            //                                 fontSize: 13,
            //                               ),
            //                             ),
            //                           ],
            //                         ),
            //                       )),
            //                       const SizedBox(height: 8),
            //                     ],
            //                   );
            //                 },
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                DefaultAppBar(
                  titleText: "My Wallet",
                  isFormBottamNav: false,
                ),

                /// ================= WALLET CARD =================
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: _walletCard(context),
                  ),
                ),

                /// ================= TRANSACTIONS =================
                Obx(() {
                  final isLoading = controller.isLoading.value;
                  final transactions = controller.transactions;

                  /// 🔵 Loading shimmer
                  if (isLoading && transactions.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: TransactionShimmer(),
                      ),
                    );
                  }

                  /// 🟡 Empty state
                  if (transactions.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Center(
                          child: Text(
                            "No transactions yet",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                      ),
                    );
                  }

                  /// 🟢 Grouped Transactions (EXACT SAME UI)
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, groupIndex) {
                        final group = controller.groupKeys[groupIndex];
                        final items = controller.groupedTransactions[group]!;

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// ---- DATE HEADER ----
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child: Text(
                                  group,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),

                              /// ---- TRANSACTIONS ----
                              ...items.map(
                                    (tx) => Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.secondary,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              tx.description,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          Text(
                                            controller.formatAmount(
                                                tx.amount, tx.type),
                                            style: TextStyle(
                                              color: tx.type == "WITHDRAW"
                                                  ? Colors.red
                                                  : Colors.green,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        "${DateFormat('dd MMMM yyyy').format(tx.createdAt.toLocal())} | ${controller.formatTime(tx.createdAt)}",
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.7),
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      childCount: controller.groupKeys.length,
                    ),
                  );
                }),

                const SliverPadding(padding: EdgeInsets.only(bottom: 20)),
              ],
            ),



          );
        }),
      ),
    );
  }
  Widget _walletCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      height: 0.17.toHeightPercent(),
      width: 1.toWidthPercent(),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Wallet Balance", style: TextStyle(fontSize: 15)),
                  Obx(() => Text(
                    "₹ ${controller.currentBalance.value.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ],
              ),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SvgPicture.asset(appbar_wallet_icon),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          InkWell(
            onTap: () async {
              final user = await AuthStorage.getUserFromPrefs();
              final userId = user?.id ?? "";
              if (userId.isEmpty) return;

              controller.isWalletAvailable.value
                  ? _showDepositWalletDialog(context, userId: userId)
                  : controller.createWallet();
            },
            child: Container(
              alignment: Alignment.center,
              height: 56,
              width: 1.toWidthPercent(),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.primary,
              ),
              child: Obx(() => Text(
                controller.isWalletAvailable.value
                    ? "Add Money"
                    : "Create Wallet",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(WalletModel tx) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  tx.description,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Text(
                controller.formatAmount(tx.amount, tx.type),
                style: TextStyle(
                  color: tx.type == "WITHDRAW"
                      ? Colors.red
                      : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            "${DateFormat('dd MMM yyyy').format(tx.createdAt)} | ${controller.formatTime(tx.createdAt)}",
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }


  void _showDepositWalletDialog(
      BuildContext context, {
        required String userId,
      }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return _DepositDialogContent(
          userId: userId,
          controller: controller,
          onSuccess: () {
            controller.fetchWalletData(refresh: true);
          },
        );
      },
    );
  }
}

class _DepositDialogContent extends StatefulWidget {
  final String userId;
  final WalletController controller;
  final VoidCallback onSuccess;

  const _DepositDialogContent({
    required this.userId,
    required this.controller,
    required this.onSuccess,
  });

  @override
  State<_DepositDialogContent> createState() => _DepositDialogContentState();
}

class _DepositDialogContentState extends State<_DepositDialogContent> {
  late TextEditingController amountController;
  late TextEditingController descriptionController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  late RazorpayService _razorpayService;

  @override
  void initState() {
    super.initState();
    _razorpayService = RazorpayService(keyId: keyId, keySecret: secretId);
    amountController = TextEditingController();
    descriptionController = TextEditingController(text: 'Top-up bonus');

  }

  @override
  void dispose() {
    amountController.dispose();
    descriptionController.dispose();
    _razorpayService.dispose();
    Get.delete<PaymentMethodsController>();
    super.dispose();
  }
  void _initiatePayment(double amount,String description,String orderId,String key) {
    print("amount check${amount.toString()}");
    _razorpayService.startPayment(
      context: context,
      amount: amount,
      key: key,
      orderId: orderId,
      description: 'Wallet Recharge',
      email: 'needowuser@example.com',
      phoneNumber: '9876543210',
      onSuccess: (PaymentSuccessResponse response) async {
        try {
          print("adding money");
          final success = await widget.controller.addMoney(
            userId: widget.userId,
            amount: amount*0.01,
            description: description,
          );

          if (!mounted) return;

          setState(() {
            isLoading = false;
          });

          if (success) {
            Navigator.of(context).pop();
            widget.onSuccess();
            AppSnackBar.showSuccess(
              context,
              message: 'Successfully deposited ₹$amount to wallet',
            );
            setState(() {
              isLoading = false;
            });
          } else {
            AppSnackBar.showError(
              context,
              message: 'Failed to deposit. Please try again.',
            );
            setState(() {
              isLoading = false;
            });
          }
        } catch (e) {
          if (!mounted) return;
          setState(() {
            isLoading = false;
          });
          AppSnackBar.showError(
            context,
            message: 'Error: ${e.toString()}',
          );
        }
      },
      onFailure: (PaymentFailureResponse response) {
        AppSnackBar.showError(
          context,
          message: 'Payment Failed: ${response.message}',

        );
        setState(() {
          isLoading = false;
        });
      },
    );
  }
  void _handleDeposit() async {
    Get.put(PaymentMethodsController());
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      print("creating order amount ${amountController.text}");
      final amount = double.parse(amountController.text);
      print("creating order amount ${amount}");
      final description = descriptionController.text.trim();
      final response = await Get.find<PaymentMethodsController>().createRezorpayOrder(amount!, "Wallet Recharge")
      .timeout(
        Duration(seconds: 30),
        onTimeout: () {
          setState(() {
            isLoading = false;
          });});
      if (response != null && response['statusCode'] == 200) {
        final data = response['data'];
        print("data in process ${data['amount']}");
        // Extract response data
        String razorpayOrderId = data['razorpayOrderId'];
        int amount = data['amount'];
        String currency = data['currency'];
        String keyId = data['key_id'];

        print("[PaymentMethodsController] Initiating Razorpay Payment");
        _initiatePayment(amount.toDouble(), description, razorpayOrderId,keyId);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: const Text(
        'Deposit to Wallet',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 0.8.toWidthPercent(),),

              // Amount Input Field
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: TextFormField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  enabled: !isLoading,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    hintText: 'Enter amount',
                    prefixIcon: const Icon(
                      Icons.currency_rupee,
                      color: AppColors.primary,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.primary),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an amount';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid amount';
                    }
                    if (double.parse(value) <= 0) {
                      return 'Amount must be greater than 0';
                    }
                    return null;
                  },
                ),
              ),

              // Description Input Field
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: TextFormField(
                  controller: descriptionController,
                  maxLines: 3,
                  enabled: !isLoading,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    hintText: 'e.g., Top-up bonus',
                    prefixIcon: const Icon(
                      Icons.description,
                      color: AppColors.primary,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.primary),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
              ),

              // Loading indicator
              if (isLoading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        ),
      ),
      actions: [
        // Cancel Button
        TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          onPressed: isLoading
              ? null
              : () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.grey),
          ),
        ),

        // Deposit Button
        ElevatedButton(
          onPressed: isLoading ? null : _handleDeposit,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            disabledBackgroundColor: Colors.grey[400],
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: isLoading
              ? const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          )
              : const Text(
            'Deposit',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}