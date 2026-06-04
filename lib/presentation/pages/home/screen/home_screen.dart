import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zesty_go_resturant/presentation/routes/app_routes.dart';
import '../../../../domain/controller/bottom_navbar_controller.dart';
import '../../../../domain/controller/dashboard_controller.dart';
import '../../../../domain/repository/dashboard_repository.dart';
import '../../../common_widget/custom_app_bar.dart';
import '../../../const/app_const_dimensions.dart';
import '../../../const/app_const_theme.dart';
import '../../../const/styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstColor.backgroundGray,
      appBar: CustomAppBar(
        title: "Dashboard",
        isBackButtonExist: false,
        centerTitle: false,
        backgroundColor: AppConstColor.backgroundGray,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            Text(
              "Hello, ZestyGo! 👋",
              style: displayBase(
                context,
              )?.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text("Here's what's happening today", style: caption(context)),

            const SizedBox(height: 25),

            Text("Performance", style: headline(context)),
            const SizedBox(height: 16),

            GetBuilder<DashboardController>(
              init: DashboardController(repo: Get.find<DashboardRepository>()),
              builder: (ctrl) {
                if (ctrl.isLoading) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                return GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1.2,
                  children: [
                    _buildStatCard(
                      context,
                      "Today",
                      "৳${ctrl.todayEarning.toStringAsFixed(0)}",
                      "${ctrl.todayOrders} Orders",
                      Icons.bolt_rounded,
                      const Color(0xFFFFF7ED),
                    ),
                    _buildStatCard(
                      context,
                      "Weekly",
                      "৳${ctrl.weeklyEarning.toStringAsFixed(0)}",
                      "${ctrl.weeklyOrders} Orders",
                      Icons.trending_up_rounded,
                      const Color(0xFFF0FDF4),
                    ),
                    _buildStatCard(
                      context,
                      "Monthly",
                      "৳${ctrl.monthlyEarning.toStringAsFixed(0)}",
                      "${ctrl.monthlyOrders} Orders",
                      Icons.calendar_today_rounded,
                      const Color(0xFFEFF6FF),
                    ),
                    _buildStatCard(
                      context,
                      "Yearly",
                      "৳${ctrl.yearlyEarning.toStringAsFixed(0)}",
                      "${ctrl.yearlyOrders} Orders",
                      Icons.analytics_rounded,
                      const Color(0xFFFAF5FF),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 25),
            Text("Quick Actions", style: headline(context)),
            const SizedBox(height: 12),
            _buildQuickActions(context),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String label,
    String value,
    String sub,
    IconData icon,
    Color bgColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppConstColor.primaryColor, size: 20),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                child: Text(
                  value,
                  style: headline(context)?.copyWith(
                    color: AppConstColor.textBlackColor,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: caption(context)?.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                sub,
                style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return GetBuilder<BottomNavbarController>(
      init: Get.isRegistered<BottomNavbarController>()
          ? null
          : BottomNavbarController(),
      builder: (navbarController) {
        return Row(
          children: [
            GestureDetector(
              onTap: () {
                Get.toNamed(RouteName.ADD_MENU);
              },
              child: _actionItem(context, Icons.add_box_rounded, "Add Menu"),
            ),
            const SizedBox(width: 30),
            GestureDetector(
              onTap: () {
                navbarController.changeIndex(2);
              },
              child: _actionItem(context, Icons.list_alt_rounded, "Orders"),
            ),
          ],
        );
      },
    );
  }

  Widget _actionItem(BuildContext context, IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 5),
            ],
          ),
          child: Icon(icon, color: AppConstColor.primaryColor),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: caption(
            context,
          )?.copyWith(fontSize: 11, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
