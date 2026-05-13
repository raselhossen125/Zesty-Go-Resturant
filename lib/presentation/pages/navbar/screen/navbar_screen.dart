import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zesty_go_resturant/presentation/pages/menu/screen/menu_screen.dart';
import '../../../../domain/controller/bottom_navbar_controller.dart';
import '../../../const/app_const_dimensions.dart';
import '../../../const/app_const_theme.dart';
import '../../home/screen/home_screen.dart';

class BottomNavBarScreen extends StatelessWidget {
  const BottomNavBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller-ti find kora hochhe (DI container theke)
    final BottomNavbarController navCont = Get.find<BottomNavbarController>();

    final List<Widget> _screens = [
      const HomeScreen(),
      const MenuScreen(),
      const Center(child: Text("Orders Page")),
      const Center(child: Text("Profile Page")),
    ];

    return Scaffold(
      body: GetBuilder<BottomNavbarController>(
        builder: (_) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _screens[navCont.selectedIndex],
          );
        },
      ),
      bottomNavigationBar: _buildBottomNav(navCont),
    );
  }

  Widget _buildBottomNav(BottomNavbarController navCont) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_OVER_EXTRA_LARGE),
        child: GetBuilder<BottomNavbarController>(
          builder: (_) {
            return BottomNavigationBar(
              currentIndex: navCont.selectedIndex,
              onTap: (index) => navCont.changeIndex(index),
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppConstColor.backgroundGray,
              selectedItemColor: AppConstColor.primaryColor,
              unselectedItemColor: Colors.grey.shade500,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedLabelStyle: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: const TextStyle(fontSize: 10),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.grid_view_rounded),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.restaurant_menu_rounded),
                  label: 'Menu',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.receipt_long_rounded),
                  label: 'Orders',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_pin_rounded),
                  label: 'Profile',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
