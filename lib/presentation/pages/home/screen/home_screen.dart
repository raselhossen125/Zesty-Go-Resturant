import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zesty_go_resturant/presentation/routes/app_routes.dart';
import '../../../../domain/controller/bottom_navbar_controller.dart';
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
        menuWidget: Container(
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 5),
            ],
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_active_outlined,
              color: AppConstColor.primaryColor,
            ),
          ),
        ),
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

            GridView.count(
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
                  "৳30,000",
                  "49 Orders",
                  Icons.bolt_rounded,
                  const Color(0xFFFFF7ED),
                ),
                _buildStatCard(
                  context,
                  "Weekly",
                  "৳2,50,000",
                  "350 Orders",
                  Icons.trending_up_rounded,
                  const Color(0xFFF0FDF4),
                ),
                _buildStatCard(
                  context,
                  "Monthly",
                  "৳50,50,000",
                  "10k Orders",
                  Icons.calendar_today_rounded,
                  const Color(0xFFEFF6FF),
                ),
                _buildStatCard(
                  context,
                  "Yearly",
                  "৳2,00,00,000",
                  "100k Orders",
                  Icons.analytics_rounded,
                  const Color(0xFFFAF5FF),
                ),
              ],
            ),

            const SizedBox(height: 25),

            _buildModernBanner(context),

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

  Widget _buildModernBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2D3C59), Color(0xFF1F2C52)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1F2C52).withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.white24,
            child: Icon(Icons.pie_chart, color: Colors.white),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Sales Report",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "Your business grew 12% this month",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 14),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return GetBuilder<BottomNavbarController>(
      builder: (navbarController) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Get.toNamed(RouteName.ADD_MENU);
              },
              child: _actionItem(context, Icons.add_box_rounded, "Add Menu"),
            ),
            GestureDetector(
              onTap: () {
                navbarController.changeIndex(2);
              },
              child: _actionItem(context, Icons.list_alt_rounded, "Orders"),
            ),
            _actionItem(context, Icons.campaign_rounded, "Promo"),
            _actionItem(context, Icons.settings_suggest_rounded, "Settings"),
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
