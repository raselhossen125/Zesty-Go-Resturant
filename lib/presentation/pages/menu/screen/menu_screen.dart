import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../domain/controller/menu_controller.dart';
import '../../../common_widget/custom_app_bar.dart';
import '../../../const/app_const_assets.dart';
import '../../../const/app_const_dimensions.dart';
import '../../../const/app_const_theme.dart';
import '../../../const/styles.dart';
import '../../../routes/app_routes.dart';
import '../widget/menu_delete_dialog.dart';
import '../widget/menu_edit_dialog.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MyMenuController controller = Get.put(MyMenuController());

    return Scaffold(
      backgroundColor: AppConstColor.backgroundGray,
      appBar: const CustomAppBar(
        title: "Menu Categories",
        isBackButtonExist: false,
        centerTitle: false,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(RouteName.ADD_MENU),
        backgroundColor: AppConstColor.primaryColor,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add_rounded, color: Colors.white, size: 30),
      ),

      body: GetBuilder<MyMenuController>(
        builder: (controller) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT,
              vertical: Dimensions.PADDING_SIZE_SMALL,
            ),
            itemCount: controller.categories.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              String categoryName = controller.categories[index];
              // Ekhon null pathaleo error hobe na
              return _buildCategoryCard(
                context,
                categoryName,
                index,
                controller,
              );
            },
          );
        },
      ),
    );
  }

  // MenuScreen card builder er logic update:
  Widget _buildCategoryCard(
    BuildContext context,
    String title,
    int index,
    MyMenuController controller,
  ) {
    return GestureDetector(
      onTap: () {
        controller.setCategoryIndex(index);
        Get.toNamed(RouteName.VIEW_DETAILS);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppConstColor.primaryColor.withOpacity(0.06),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            // Image Section
            Container(
              width: 100,
              height: 100,
              padding: const EdgeInsets.all(12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  color: AppConstColor.primaryColor.withOpacity(0.05),
                  child: Image.asset(
                    AppConstAssets.burger, // Apnar image logic ekhane thakbe
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) => Icon(
                      Icons.fastfood_rounded,
                      color: AppConstColor.primaryColor,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),

            // Info Section
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: headline(
                      context,
                    )?.copyWith(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Explore Menu",
                      style: caption(context)?.copyWith(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Action Button
            PopupMenuButton<String>(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              icon: const Icon(Icons.more_vert_rounded, color: Colors.grey),
              // MenuScreen er PopupMenuButton er onSelected logic:
              // MenuScreen er PopupMenuButton onSelected logic:
              onSelected: (value) {
                if (value == 'view') {
                  controller.setCategoryIndex(index);
                  Get.toNamed(RouteName.VIEW_DETAILS);
                } else if (value == 'edit') {
                  // Rename/Edit er jonno Bottom Sheet call
                  showImagePickerBottomSheet(context, title);
                } else if (value == 'delete') {
                  // Sundor Delete Dialog call
                  showMenuDeleteDialog(context, title);
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'view', child: Text('View Details')),
                const PopupMenuItem(value: 'edit', child: Text('Rename')),
                const PopupMenuItem(
                  value: 'delete',
                  child: Text('Delete', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }

  // Default Icon Builder
  Widget _buildDefaultIcon() {
    return Icon(
      Icons.restaurant_menu_rounded, // Menu-r jonno perfect icon
      color: AppConstColor.primaryColor,
      size: 30,
    );
  }

  PopupMenuItem<String> _buildPopupItem(
    String value,
    IconData icon,
    String title, {
    bool isDelete = false,
  }) {
    return PopupMenuItem(
      value: value,
      child: Row(
        children: [
          Icon(icon, size: 18, color: isDelete ? Colors.red : Colors.black87),
          const SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              color: isDelete ? Colors.red : Colors.black87,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
