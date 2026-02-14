import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:newdow_customer/features/address/controller/addressController.dart';
import 'package:newdow_customer/features/address/controller/pickDefaultAddressController.dart';
import 'package:newdow_customer/features/address/model/services/addressServices.dart';
import 'package:newdow_customer/features/auth/model/services/auth_services.dart';
import 'package:newdow_customer/features/browseProducts/controller/searchController.dart';
import 'package:newdow_customer/features/browseProducts/models/services/searchService.dart';
import 'package:newdow_customer/features/cart/controller/cart_controller.dart';
import 'package:newdow_customer/features/cart/controller/checkout_controller.dart';
import 'package:newdow_customer/features/cart/model/services/cart_service.dart';
import 'package:newdow_customer/features/home/controller/bannerController.dart';
import 'package:newdow_customer/features/home/model/bannerService/banner_service.dart';
import 'package:newdow_customer/features/home/model/businessServices/business_type_service.dart';
import 'package:newdow_customer/features/home/model/categoryAndSubcategoryServices/categoryAndSubcategoryService.dart';
import 'package:newdow_customer/features/notification/controller/notification_controller.dart';
import 'package:newdow_customer/features/notification/service/notification_service.dart';
import 'package:newdow_customer/features/orders/controllers/orderController.dart';
import 'package:newdow_customer/features/orders/model/services/order_services.dart';
import 'package:newdow_customer/features/payment/model/services/paymentService.dart';
import 'package:newdow_customer/features/payment/paymentServices/makePaymentService.dart';
import 'package:newdow_customer/features/product/controller/productContorller.dart';
import 'package:newdow_customer/features/product/models/services/product_service.dart';
import 'package:newdow_customer/features/profile/controller/privacyPolicyController.dart';
import 'package:newdow_customer/features/profile/controller/profile_controller.dart';
import 'package:newdow_customer/features/profile/controller/wallet_controller.dart';
import 'package:newdow_customer/features/cart/model/services/couponServices.dart';
import 'package:newdow_customer/features/profile/model/services/privacyPolicyService.dart';
import 'package:newdow_customer/features/profile/model/services/profileService.dart';
import 'package:newdow_customer/features/profile/model/services/waller_service.dart';
import 'package:newdow_customer/utils/constants.dart';
import 'package:newdow_customer/widgets/appbutton.dart';

import '../features/auth/controller/auth_controller.dart';
import '../features/cart/controller/cupoonController.dart';
import '../features/home/controller/buisnessController.dart';
import '../features/home/controller/categoryAndSubcategoryController.dart';
import '../features/home/foodSection/restaurent/controller/recomendedProductContrller.dart';
import '../features/home/foodSection/restaurent/controller/restaurentController.dart';
import '../features/home/foodSection/restaurent/model/services/restaurentService.dart';

// class  ServiceLocater{
//   static final  serviceLocator = GetInstance();
//
//   static void  initServices(){
//
//
//
//
//     //servies
//     serviceLocator.put<LoadingController>(LoadingController());
//     serviceLocator.put<AuthService>(AuthService());
//     serviceLocator.put<ProductService>(ProductServiceImpl());
//     serviceLocator.put<CartService>(CartServiceImpl());
//     serviceLocator.put<SearchService>(SearchServiceImpl());
//     //serviceLocator.put(RazorpayService(keyId: keyId, keySecret: secretId ));
//     serviceLocator.put<BannerService>(BannerServiceImpl());
//     serviceLocator.put<BusinessTypeService>(BusinessTypeServiceImpl());
//     serviceLocator.put<CategoryAndSubcategoryService>(CategoryAndSubcategoryServiceImpl());
//     serviceLocator.put<CouponService>(CouponServiceImpl());
//     serviceLocator.put<PrivacyPolciyService>(PrivacyPolciyServiceImpl());
//     serviceLocator.put<ProfileService>(ProfileServiceImpl());
//     serviceLocator.put<OrderService>(OrderServiceImpl());
//     serviceLocator.put<AddressService>(AddressServicesImpl());
//     serviceLocator.put<NotificationService>(NotificationServiceImpl());
//     serviceLocator.put<WalletService>(WalletServiceImpl());
//     serviceLocator.put<RestaurentService>(RestaurentServiceImpl());
//     serviceLocator.put<PaymentService>(PaymentServiceImpl());
//
//
//
//
//
//   //controllers
//   serviceLocator.put<PhoneAuthController>(PhoneAuthController());
//   serviceLocator.put<ProfileController>(ProfileController());
//   serviceLocator.put<ProductController>(ProductController());
//   serviceLocator.put<CheckoutController>(CheckoutController());
//   serviceLocator.put<CartController>(CartController());
//   serviceLocator.put<BannerController>(BannerController());
//     serviceLocator.put<ProductSearchController>(ProductSearchController());
//   serviceLocator.put(BusinessController(), permanent: true);
//   serviceLocator.put<CategoryAndSubcategoryController>(CategoryAndSubcategoryController());
//   serviceLocator.put<CouponController>(CouponController());
//   serviceLocator.put<Privacypolicycontroller>(Privacypolicycontroller());
//   serviceLocator.put<ProfileController>(ProfileController());
//   serviceLocator.put<OrderController>(OrderController());
//   serviceLocator.put<AddressController>(AddressController());
//   serviceLocator.put<CheckoutController>(CheckoutController());
//   serviceLocator.put<PickDefaultAddressController>(PickDefaultAddressController());
//   serviceLocator.put<ResturentController>(ResturentController());
//     serviceLocator.put<NotificationController>(
//       NotificationController(serviceLocator.find<NotificationService>()),
//     );
//  // serviceLocator.put<WalletController>(
//  //      WalletController(serviceLocator.find<WalletService>()),
//  //    );
//     serviceLocator.put<WalletController>(WalletController());
//
//
//
//
//  }
// }
class ServiceLocater {
  static final serviceLocator = GetInstance();

  /// Initial app bootstrap
  static void initServices() {
    _registerServices();
    _registerControllers();
  }

  /// 🔥 Call this on LOGOUT
  static void reset() {
    // Force delete EVERYTHING
    serviceLocator.deleteAll();

    // OPTIONAL: re-register core services only
    initServices();
  }

  // ---------------- PRIVATE METHODS ----------------

  static void _registerServices() {
    serviceLocator.put<LoadingController>(LoadingController());
    serviceLocator.put<AuthService>(AuthService());
    serviceLocator.put<ProductService>(ProductServiceImpl());
    serviceLocator.put<CartService>(CartServiceImpl());
    serviceLocator.put<SearchService>(SearchServiceImpl());
    serviceLocator.put<BannerService>(BannerServiceImpl());
    serviceLocator.put<BusinessTypeService>(BusinessTypeServiceImpl());
    serviceLocator.put<CategoryAndSubcategoryService>(
        CategoryAndSubcategoryServiceImpl());
    serviceLocator.put<CouponService>(CouponServiceImpl());
    serviceLocator.put<PrivacyPolciyService>(PrivacyPolciyServiceImpl());
    serviceLocator.put<ProfileService>(ProfileServiceImpl());
    serviceLocator.put<OrderService>(OrderServiceImpl());
    serviceLocator.put<AddressService>(AddressServicesImpl());
    serviceLocator.put<NotificationService>(NotificationServiceImpl());
    serviceLocator.put<WalletService>(WalletServiceImpl());
    serviceLocator.put<RestaurentService>(RestaurentServiceImpl());
    serviceLocator.put<PaymentService>(PaymentServiceImpl());
  }

  static void _registerControllers() {
    serviceLocator.put<PhoneAuthController>(PhoneAuthController());
    serviceLocator.put<ProfileController>(ProfileController());
    serviceLocator.put<ProductController>(ProductController());
    serviceLocator.put<RecomendedProductController>(RecomendedProductController());
    serviceLocator.put<CartController>(CartController());
    serviceLocator.put<CheckoutController>(CheckoutController());
    serviceLocator.put<BannerController>(BannerController());
    serviceLocator.put<ProductSearchController>(ProductSearchController());
    serviceLocator.put<BusinessController>(BusinessController(),
        permanent: true);
    serviceLocator.put<CategoryAndSubcategoryController>(
        CategoryAndSubcategoryController());
    serviceLocator.put<CouponController>(CouponController());
    serviceLocator.put<Privacypolicycontroller>(Privacypolicycontroller());
    serviceLocator.put<OrderController>(OrderController());
    serviceLocator.put<AddressController>(AddressController());
    serviceLocator.put<PickDefaultAddressController>(
        PickDefaultAddressController());
    serviceLocator.put<ResturentController>(ResturentController());
    serviceLocator.put<NotificationController>(
      NotificationController(serviceLocator.find<NotificationService>()),
    );
    serviceLocator.put<WalletController>(WalletController());
  }
}
