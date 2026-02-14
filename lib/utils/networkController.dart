import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkController extends GetxController {
  // Observable internet status
  RxBool hasInternet = true.obs;

  @override
  void onInit() {
    super.onInit();

    // Listen to internet changes
    InternetConnectionChecker()
        .onStatusChange
        .listen((status) {
      hasInternet.value = (status == InternetConnectionStatus.connected);
    });
  }
}
