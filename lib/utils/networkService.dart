import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkService extends GetxService {
  static NetworkService get to => Get.find<NetworkService>();

  RxBool isOnline = true.obs;

  Future<NetworkService> init() async {
    // Check initial internet
    isOnline.value = await InternetConnectionChecker().hasConnection;

    // Listen to connectivity changes
    Connectivity().onConnectivityChanged.listen((result) async {
      bool connection = await InternetConnectionChecker().hasConnection;
      isOnline.value = connection;
    });

    return this;
  }
}
