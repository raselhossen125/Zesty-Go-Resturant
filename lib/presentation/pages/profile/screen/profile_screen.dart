import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zesty_go_resturant/presentation/routes/app_routes.dart';
import '../../../../domain/controller/profile_controller.dart';
import '../../../common_widget/custom_app_bar.dart';
import '../../../const/app_const_assets.dart';
import '../../helpAndSupport/screen/help_and_support_screeen.dart';
import '../../privacyPolicy/screen/privacy_policy_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: const CustomAppBar(
        title: "Profile",
        centerTitle: false,
        isBackButtonExist: false,
      ),
      body: GetBuilder<ProfileController>(
        init: Get.isRegistered<ProfileController>()
            ? null
            : ProfileController(),
        builder: (controller) {
          if (controller.profile == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final pData = controller.profile!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.grey[100],
                        backgroundImage: pData.imageUrl.trim().isNotEmpty
                            ? NetworkImage(pData.imageUrl.trim())
                            : const AssetImage(AppConstAssets.burger)
                                  as ImageProvider,
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pData.name.isEmpty
                                  ? "Restaurant Name"
                                  : pData.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(
                                  Icons.phone,
                                  size: 14,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    pData.phone,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 3),
                            Row(
                              children: [
                                const Icon(
                                  Icons.email,
                                  size: 14,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    pData.email,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => Get.toNamed(RouteName.EDIT_PROFILE),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                            0xFFFFE5B4,
                          ).withOpacity(0.7),
                          foregroundColor: Colors.orange,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          minimumSize: const Size(60, 32),
                          shape: const StadiumBorder(),
                        ),
                        child: const Text(
                          "Edit",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                Text(
                  "Support & Legal",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 15),

                // ✂️ "My Orders" মেনু আইটেমটি এখান থেকে বাদ দেওয়া হয়েছে
                _buildMenuItem(
                  icon: Icons.help_outline,
                  title: "Help & Support",
                  subtitle: "Contact us.",
                  onTap: () => Get.to(() => const HelpSupportScreen()),
                ),

                _buildMenuItem(
                  icon: Icons.privacy_tip_outlined,
                  title: "Privacy Policy",
                  subtitle: "policy details",
                  onTap: () => Get.to(() => const PrivacyPolicyScreen()),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMenuItem({
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.orange, size: 22),
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
          size: 13,
          color: Colors.grey,
        ),
        onTap: onTap,
      ),
    );
  }
}
