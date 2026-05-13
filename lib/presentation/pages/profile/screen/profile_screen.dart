import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zesty_go_resturant/presentation/routes/app_routes.dart';
import '../../../../domain/controller/profile_controller.dart';
import '../../../common_widget/custom_app_bar.dart';
import '../../../const/app_const_assets.dart';
import '../../../const/app_const_dimensions.dart';
import '../../../const/app_const_theme.dart';
import '../../../const/styles.dart';
import 'edit_profile_screen.dart'; // Apnar edit screen path

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller find (DI container e initialize kora thakle)
    final ProfileController controller = Get.find<ProfileController>();

    return Scaffold(
      backgroundColor: AppConstColor.backgroundGray,
      appBar: const CustomAppBar(
        title: "Profile",
        isBackButtonExist: false,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Profile Info Card (ZestyGo)
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
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          // Restaurant Logo
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.grey[200],
                            backgroundImage: ctrl.pickedImage != null
                                ? FileImage(ctrl.pickedImage!)
                                : AssetImage(AppConstAssets.burger)
                                      as ImageProvider,
                          ),
                          const SizedBox(width: 15),

                          // Restaurant Name
                          Expanded(
                            child: Text(
                              ctrl.name.value,
                              style: headline(context)?.copyWith(fontSize: 20),
                            ),
                          ),

                          // Edit Button
                          SizedBox(
                            height: 30,
                            child: ElevatedButton(
                              onPressed: () {
                                Get.toNamed(RouteName.EDIT_PROFILE);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(
                                  0xFFFFE5B4,
                                ).withOpacity(0.5),
                                elevation: 0,
                                shape: const StadiumBorder(),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                              ),
                              child: const Text(
                                "Edit",
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),

                      // Order Count Box (Blue dotted style)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue.withOpacity(0.3),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${ctrl.orderCount.value}",
                              style: headline(context)?.copyWith(fontSize: 22),
                            ),
                            Text(
                              "Orders",
                              style: caption(
                                context,
                              )?.copyWith(color: Colors.grey),
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
            const Text(
              "Delivery Info",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 15),

            // 2. Menu Options List
            _buildProfileMenu(
              context,
              icon: Icons.assignment_outlined,
              title: "My Orders",
              subtitle: "View past & ongoing orders",
              onTap: () {
                // Navigate to My Orders
              },
            ),
            _buildProfileMenu(
              context,
              icon: Icons.help_outline,
              title: "Help & Support",
              subtitle: "Contact us.",
              onTap: () {},
            ),
            _buildProfileMenu(
              context,
              icon: Icons.privacy_tip_outlined,
              title: "Privacy Policy",
              subtitle: "policy details",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  // Profile Menu Item Builder
  Widget _buildProfileMenu(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        onTap: onTap,
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
          style: bodyMedium(context)?.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle, style: caption(context)),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey,
        ),
      ),
    );
  }
}
