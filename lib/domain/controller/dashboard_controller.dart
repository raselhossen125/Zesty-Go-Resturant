import 'package:get/get.dart';
import '../repository/dashboard_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardController extends GetxController {
  final DashboardRepository repo;

  DashboardController({required this.repo});

  bool isLoading = false;

  double todayEarning = 0;
  double weeklyEarning = 0;
  double monthlyEarning = 0;
  double yearlyEarning = 0;

  int todayOrders = 0;
  int weeklyOrders = 0;
  int monthlyOrders = 0;
  int yearlyOrders = 0;

  @override
  void onInit() {
    super.onInit();
    fetchStats();
  }

  Future<void> fetchStats() async {
    isLoading = true;
    update();

    final dataList = await repo.getOrders();
    final now = DateTime.now();

    double tE = 0, wE = 0, mE = 0, yE = 0;
    int tO = 0, wO = 0, mO = 0, yO = 0;

    for (var data in dataList) {
      // only delivered orders
      final status = (data['status'] ?? '').toString().toLowerCase();
      if (status != 'delivered') continue;

      final total = (data['totalAmount'] ?? 0).toDouble();
      final timestamp = data['createdAt'];
      if (timestamp == null) continue;

      final DateTime date = (timestamp as Timestamp).toDate();

      bool isToday =
          date.year == now.year &&
          date.month == now.month &&
          date.day == now.day;

      bool isWeek = now.difference(date).inDays <= 7;
      bool isMonth = date.year == now.year && date.month == now.month;
      bool isYear = date.year == now.year;

      if (isToday) {
        tE += total;
        tO++;
      }

      if (isWeek) {
        wE += total;
        wO++;
      }

      if (isMonth) {
        mE += total;
        mO++;
      }

      if (isYear) {
        yE += total;
        yO++;
      }
    }

    todayEarning = tE;
    weeklyEarning = wE;
    monthlyEarning = mE;
    yearlyEarning = yE;

    todayOrders = tO;
    weeklyOrders = wO;
    monthlyOrders = mO;
    yearlyOrders = yO;

    isLoading = false;
    update();
  }
}
