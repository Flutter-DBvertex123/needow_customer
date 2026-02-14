// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:newdow_customer/features/cart/controller/cart_controller.dart';
// import 'package:newdow_customer/features/cart/model/models/cartModel.dart';
// import 'package:newdow_customer/utils/constants.dart';
// import 'package:newdow_customer/utils/getSize.dart';
// import 'package:newdow_customer/widgets/appbar.dart';
// import 'package:newdow_customer/widgets/snackBar.dart';
// import 'package:newdow_customer/features/cart/model/models/cartItemsModel.dart';
//
// import '../../../utils/apptheme.dart';
// import '../../../widgets/appbutton.dart';
// import '../../../widgets/imageHandler.dart';
// import 'chekout_screen.dart';
//
// class CartList extends StatefulWidget {
//   final bool isFromBottamNav;
//   const CartList({super.key, required this.isFromBottamNav});
//
//   @override
//   State<CartList> createState() => _CartListState();
// }
//
// class _CartListState extends State<CartList> {
//   final cartCon = Get.find<CartController>();
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       cartCon.fetchCarts(); // ✅ safe to call here
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: SafeArea(
//         child: Container(
//           decoration: const BoxDecoration(
//             color: Color(0xFFF9F9F9),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 10,
//                 offset: Offset(0, -2),
//               ),
//             ],
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           height: 0.14.toHeightPercent(),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text("Total",
//                       style:
//                       TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                   Obx(() => Text(
//                     "₹${cartCon.grandTotal.toStringAsFixed(2)}",
//                     style: const TextStyle(
//                         fontSize: 18, fontWeight: FontWeight.bold),
//                   )),
//                 ],
//               ),
//               const SizedBox(height: 8),
//               Appbutton(
//                   buttonText: "Checkout",
//                   onTap: () {
//                     Get.to(() =>  CheckoutScreen(carts: cartCon.cartList,));
//                   },
//                   isLoading: false),
//             ],
//           ),
//         ),
//       ),
//       body: SafeArea(
//         top: false,
//         child: CustomScrollView(
//           slivers: [
//             DefaultAppBar(
//                 titleText: "My Cart", isFormBottamNav: widget.isFromBottamNav),
//
//             // ✅ Replaced FutureBuilder with Obx
//             Obx(() {
//               if (cartCon.isLoading.value) {
//                 return const SliverToBoxAdapter(
//                   child: Center(child: CircularProgressIndicator()),
//                 );
//               }
//
//               if (cartCon.errorMessage.isNotEmpty) {
//                 return SliverToBoxAdapter(
//                   child: Center(
//                       child: Text("Error: ${cartCon.errorMessage.value}")),
//                 );
//               }
//
//               if (cartCon.cartList.isEmpty) {
//                 return const SliverToBoxAdapter(
//                   child: Center(child: Text("No items in your cart")),
//                 );
//               }
//
//               return SliverToBoxAdapter(
//                 child: Column(
//                   children: [
//                     ListView.builder(
//                       physics: const NeverScrollableScrollPhysics(),
//                       padding: const EdgeInsets.all(12),
//                       shrinkWrap: true,
//                       itemCount: cartCon.cartList.length,
//                       itemBuilder: (context, index) {
//                         final cart = cartCon.cartList[index];
//                         final item = getItems(cart.items);
//
//                         return Dismissible(
//                           key: Key(cart.id.toString()),
//                           direction: DismissDirection.endToStart,
//                           background: Container(
//                             decoration: BoxDecoration(
//                               color: AppColors.secondary,
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             alignment: Alignment.centerRight,
//                             padding:
//                             const EdgeInsets.symmetric(horizontal: 20),
//                             child: SvgPicture.asset(delete_icon),
//                           ),
//                           onDismissed: (direction) async {
//                             final data = await cartCon.removeCartItem(cart.id);
//                             AppSnackBar.showSuccess(context,
//                                 message: data["message"]);
//                           },
//                           child: Card(
//                             elevation: 0.2,
//                             margin: const EdgeInsets.symmetric(vertical: 6),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(12.0),
//                               child: Row(
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       SizedBox(
//                                         height: 65,
//                                         width: 65,
//                                         child: ClipRRect(
//                                           borderRadius:
//                                           BorderRadius.circular(8),
//                                           child: SafeNetworkImage(
//                                             url: (item?.product?.imageUrl !=
//                                                 null &&
//                                                 item!.product!.imageUrl
//                                                     .isNotEmpty)
//                                                 ? item.product!.imageUrl[0]
//                                                 : "",
//                                           ),
//                                         ),
//                                       ),
//                                       const SizedBox(width: 12),
//                                       Column(
//                                         crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             item?.product?.name ?? "Unknown",
//                                             style: const TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 15),
//                                           ),
//                                           const SizedBox(height: 4),
//                                           Text(
//                                             item?.product?.productType ?? "",
//                                             style: const TextStyle(
//                                                 color: Colors.grey),
//                                           ),
//                                           const SizedBox(height: 2),
//                                           Text(
//                                             "₹${item?.product?.discountedPrice ?? 0}",
//                                             style:
//                                             const TextStyle(fontSize: 15),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                   Column(
//                                     crossAxisAlignment: CrossAxisAlignment.end,
//                                     children: [
//                                       Container(
//                                         height: 0.05.toHeightPercent(),
//                                         decoration: BoxDecoration(
//                                           color: AppColors.secondary,
//                                           borderRadius:
//                                           BorderRadius.circular(24),
//                                         ),
//                                         child: Row(
//                                           children: [
//                                             IconButton(
//                                               icon: CircleAvatar(
//                                                 radius: 15,
//                                                 backgroundColor: AppColors
//                                                     .primary
//                                                     .withValues(alpha: 0.5),
//                                                 child: const Icon(Icons.remove,
//                                                     color: Colors.white),
//                                               ),
//                                               onPressed: () async {
//                                                 if(1 == item?.quantity){
//                                                   AppSnackBar.show(context, message: "You have reached minimum order quantity");
//                                                 }else{
//                                                   List<CartItems> items = [CartItems(productId: item!.product!.id, quantity: item.quantity-1)];
//                                                   print("updating cart :- ${item.product?.id}");
//                                                   final response  = await cartCon.updateCart(cartId: cart.id, userId: cart.user.id, items: items);
//                                                   if(response){
//                                                     await cartCon.fetchCarts();
//                                                   }
//                                                 }
//                                               },
//                                             ),
//                                             Text(
//                                               item?.quantity.toString() ?? "1",
//
//                                               style: const TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 16),
//                                             ),
//                                             IconButton(
//                                               icon: CircleAvatar(
//                                                 radius: 15,
//                                                 backgroundColor:
//                                                 AppColors.primary,
//                                                 child: const Icon(Icons.add,
//                                                     color: Colors.white),
//                                               ),
//                                               onPressed: () async {
//                                                 if(item?.product?.maxOrderQuantity == item?.quantity){
//                                                   AppSnackBar.show(context, message: "You have reached maximum order qunatity");
//                                                 }else{
//                                                   List<CartItems> items = [CartItems(productId: item!.product!.id, quantity: item.quantity+1)];
//                                                   print("updating cart :- ${item.product?.id}");
//                                                   final response  = await cartCon.updateCart(cartId: cart.id, userId: cart.user.id, items: items);
//                                                   if(response){
//                                                     await cartCon.fetchCarts();
//                                                   }
//                                                 }
//                                               },
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding:
//                                         const EdgeInsets.only(right: 8),
//                                         child: Text(
//                                           "₹${cart.items.first.lineTotal.toStringAsFixed(2)}",
//                                           style: const TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 14),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//
//                     // Coupon Field
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 16, vertical: 8),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             alignment: Alignment.center,
//                             height: 0.06.toHeightPercent(),
//                             width: 0.60.toWidthPercent(),
//                             child: TextField(
//                               decoration: InputDecoration(
//                                 hintText: "Enter Coupon Code",
//                                 hintStyle: TextStyle(
//                                     color: Colors.black.withValues(alpha: 0.5)),
//                                 filled: true,
//                                 fillColor: Colors.grey[200],
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(24),
//                                   borderSide: BorderSide.none,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 10),
//                           SizedBox(
//                             height: 0.06.toHeightPercent(),
//                             width: 0.25.toWidthPercent(),
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: AppColors.primary,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(24),
//                                 ),
//                               ),
//                               onPressed: () {},
//                               child: const Text("Apply",
//                                   style: TextStyle(
//                                       color: Colors.white, fontSize: 15)),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
//
//   CartItem? getItems(List<CartItem> cartItems) {
//     if (cartItems.isNotEmpty) {
//       return cartItems.first;
//     }
//     return null;
//   }
// }
