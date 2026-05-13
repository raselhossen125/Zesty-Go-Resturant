import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zesty_go_resturant/presentation/routes/app_routes.dart';
// Apnar existing project architecture onujayi import gulo check korun
import '../../../../domain/controller/profile_controller.dart';
import '../../../const/app_const_assets.dart';
import '../../../const/app_const_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find<ProfileController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8), // Light gray background
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Top Profile Card (Screenshot Matching)
            GetBuilder<ProfileController>(
              builder: (ctrl) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          // Circle Avatar with Image
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.grey[200],
                            backgroundImage: ctrl.pickedImage != null
                                ? FileImage(ctrl.pickedImage!)
                                : const AssetImage(AppConstAssets.burger)
                                      as ImageProvider,
                          ),
                          const SizedBox(width: 15),

                          // Restaurant Name
                          Expanded(
                            child: Text(
                              ctrl.name.value,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          // Edit Button (Fixed Layout)
                          IntrinsicWidth(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                minHeight: 32,
                                maxHeight: 32,
                              ),
                              child: ElevatedButton(
                                onPressed: () =>
                                    Get.toNamed(RouteName.EDIT_PROFILE),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(
                                    0xFFFFE5B4,
                                  ).withOpacity(0.7),
                                  foregroundColor: Colors.orange,
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  shape: const StadiumBorder(),
                                ),
                                child: const Text(
                                  "Edit",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Order Count Box (Blue style border)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${ctrl.orderCount.value}",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              "Orders",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 25),
            Text(
              "Delivery Info",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 15),

            // 2. Menu List (Rounded Tiles)
            _buildMenuItem(
              icon: Icons.assignment_outlined,
              title: "My Orders",
              subtitle: "View past & ongoing orders",
            ),
            _buildMenuItem(
              icon: Icons.help_outline,
              title: "Help & Support",
              subtitle: "Contact us.",
            ),
            _buildMenuItem(
              icon: Icons.privacy_tip_outlined,
              title: "Privacy Policy",
              subtitle: "policy details",
            ),
          ],
        ),
      ),
    );
  }

  // Menu item builder to keep code clean and matching the screenshot
  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.orange, size: 24),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 14,
          color: Colors.grey,
        ),
        onTap: () {},
      ),
    );
  }
}
