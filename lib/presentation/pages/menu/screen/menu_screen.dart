import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common_widget/custom_app_bar.dart';
import '../../../const/app_const_assets.dart';
import '../../../const/app_const_dimensions.dart';
import '../../../const/app_const_theme.dart';
import '../../../const/styles.dart';
import '../../../routes/app_routes.dart';
import '../widget/menu_delete_dialog.dart';
import '../widget/menu_edit_dialog.dart';
// import correct paths for components
// import 'custom_app_bar.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstColor.backgroundGray,

      // Apnar modified CustomAppBar ekhane use kora hoyeche
      appBar: CustomAppBar(
        title: "Menu",
        isBackButtonExist: false, // Menu page-e back button lagbe na
        centerTitle: false, // Design-e title left-e ache
        backgroundColor: AppConstColor.backgroundGray,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(RouteName.ADD_MENU);
        },
        backgroundColor: AppConstColor.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return _buildMenuCard(context);
        },
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              AppConstAssets.burger,
              width: 65,
              height: 65,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Chicken Fry",
                  style: headline(context)?.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text("Total 12 items", style: caption(context)),
              ],
            ),
          ),

          // Action Popup
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.grey),
            onSelected: (value) {
              if (value == 'edit') {
                // Dialog call korar somoy method name thik rakhben
                showMenuEditDialog(context);
              } else if (value == 'delete') {
                showMenuDeleteDialog(context);
              } else if (value == 'view') {
                Get.toNamed(RouteName.VIEW_DETAILS);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'edit', child: Text('Edit menu')),
              const PopupMenuItem(value: 'delete', child: Text('Delete menu')),
              const PopupMenuItem(value: 'view', child: Text('View Details')),
            ],
          ),
        ],
      ),
    );
  }
}
