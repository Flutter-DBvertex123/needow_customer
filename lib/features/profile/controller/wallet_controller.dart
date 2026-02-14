import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:newdow_customer/widgets/snackBar.dart';
import '../../../utils/prefs.dart';
import '../model/services/waller_service.dart';
import '../model/wallet_model.dart';

class WalletController extends GetxController {



  // ==================== OBSERVABLES ====================
  late String? userId;
  RxList<WalletModel> transactions = <WalletModel>[].obs;
  RxDouble currentBalance = 0.0.obs; // Live balance from API
  RxBool isLoading = false.obs;
  RxMap<String, List<WalletModel>> groupedTransactions = <String, List<WalletModel>>{}.obs;
  RxList<String> groupKeys = <String>[].obs;
  RxBool isWalletAvailable = true.obs;


 Future<bool> withdrawMoneyForOrderPayment({
    required String userId,
    required double amount,
    required String description,
  }) async {
    final response = await Get.find<WalletService>().withdrawFromWallet(userId,  amount, description);
    response ? fetchWalletData(refresh: true) : null;
    return response;
  }

  // ==================== FETCH BOTH HISTORY + BALANCE ====================
  // Future<void> fetchWalletData({bool refresh = false}) async {
  //   final service = Get.find<WalletService>();
  //   if (isLoading.value) return;
  //   isLoading.value = true;
  //
  //   try {
  //     if (refresh) {
  //       transactions.clear();
  //       currentBalance.value = 0.0;
  //     }
  //
  //     // Parallel API calls
  //     final results = await Future.wait([
  //       service.getWalletHistory(userId ?? ""),
  //       service.getWalletBalance(userId ?? ""),
  //     ]);
  //     print("data is arrived at controller");
  //     if(results == null || results.isEmpty || results.elementAt(0) == [] || results[1] == -1 ){
  //       print("null");
  //     }
  //
  //     final List<WalletModel> history = results[0] as List<WalletModel>;
  //     final double balance = results[1] as double;
  //     transactions.assignAll(history);
  //     currentBalance.value = balance;
  //
  //     transactions.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  //     _updateGroupedTransactions();
  //
  //   } catch (e) {
  //     print("Error fetching wallet data: $e");
  //     //AppSnackBar.showWarning(context, message: "Wallet not found");
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
  Future<void> createWallet() async {
    final isWalletCreated = await Get.find<WalletService>().createWallet(userId: userId ?? "", initialBalance: 0.0);
    isWalletCreated ? isWalletAvailable.value == true :isWalletAvailable.value == false;

  }
  Future<void> fetchWalletData({bool refresh = false}) async {
    final service = Get.find<WalletService>();
    await getUserId();
    if (isLoading.value) return;
    isLoading.value = true;

    try {
      if (refresh) {
        transactions.clear();
        currentBalance.value = 0.0;
        isWalletAvailable.value = true; // reset
      }

      // Parallel API calls
      final results = await Future.wait([
        service.getWalletHistory(userId ?? ""),
        service.getWalletBalance(userId ?? ""),
      ]);

      print("data is arrived at controller");

      final List<WalletModel> history = results[0] as List<WalletModel>;
      final double balance = results[1] as double;

      // -------------------------------
      // HANDLE WALLET NOT AVAILABLE
      // -------------------------------
      if (history.isEmpty && balance == -1) {
        print("Wallet not found (404)");
        isWalletAvailable.value = false;
        transactions.clear();
        currentBalance.value = 0.0;
        return;
      } else {
        isWalletAvailable.value = true;
      }

      // -------------------------------
      // If wallet exists → set data
      // -------------------------------
      transactions.assignAll(history);
      currentBalance.value = balance;

      transactions.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      _updateGroupedTransactions();

    } catch (e) {
      print("Error fetching wallet data: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // ==================== GROUPING LOGIC (IST) ====================
  void _updateGroupedTransactions() {
    final Map<String, List<WalletModel>> map = {};
    final now = DateTime.now(); // 15 Nov 2025, 06:07 PM IST
    final todayStart = DateTime(now.year, now.month, now.day);
    final yesterdayStart = todayStart.subtract(const Duration(days: 1));

    for (var tx in transactions) {
      final localDate = tx.createdAt.toLocal(); // UTC → IST
      String key;
      if (localDate.isAfter(todayStart)) {
        key = "Today";
      } else if (localDate.isAfter(yesterdayStart)) {
        key = "Yesterday";
      } else {
        key = DateFormat("dd MMM yyyy").format(localDate);
      }
      map.putIfAbsent(key, () => []);
      map[key]!.add(tx);
    }
    groupedTransactions.assignAll(map);
    groupKeys.assignAll(map.keys.toList());
  }
  //=====================Add Money ===================

  Future<bool> addMoney({
    required String userId,
    required double amount,
    required String description,
  }) async {
    final response = await Get.find<WalletService>().addMoney(userId: userId, amount: amount, description: description);
    return response;
  }

  // ==================== HELPERS ====================
  String formatAmount(double amount, String type) {
    final sign = type == "DEPOSIT" ? "+" : "-";
    return "$sign₹${amount.toStringAsFixed(2)}";
  }

  String formatTime(DateTime date) {
    final localDate = date.toLocal(); // UTC → IST
    return DateFormat('hh:mm a').format(localDate);
  }

  // ==================== USER ID ====================
  Future<void> getUserId() async {
    final user = await AuthStorage.getUserFromPrefs();
    userId = user?.id ?? "";
  }

  // ==================== PULL TO REFRESH ====================
  Future<void> onRefresh() async {
    await fetchWalletData(refresh: true);
  }
}