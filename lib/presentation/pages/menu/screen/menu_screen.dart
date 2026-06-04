import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../domain/controller/menu_controller.dart';
import '../../../common_widget/custom_app_bar.dart';
import '../../../const/app_const_dimensions.dart';
import '../../../const/app_const_theme.dart';
import '../../../const/styles.dart';
import '../../../routes/app_routes.dart';
import '../widget/menu_delete_dialog.dart';
import '../widget/menu_edit_dialog.dart'; // Sheet location clear path dynamically matched

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MyMenuController controller = Get.find<MyMenuController>();

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
        builder: (menuController) {
          // Loading state check
          if (menuController.isLoading.value &&
              menuController.categoriesList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          // Khali list check
          if (menuController.categoriesList.isEmpty) {
            return const Center(child: Text("No Categories Found"));
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT,
              vertical: Dimensions.PADDING_SIZE_SMALL,
            ),
            itemCount: menuController.categoriesList.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              DocumentSnapshot categoryDoc =
                  menuController.categoriesList[index];
              Map<String, dynamic> data =
                  categoryDoc.data() as Map<String, dynamic>;

              String categoryName = data['categoryName'] ?? "Unknown";
              String categoryImageUrl = data['image']?['url'] ?? "";

              return _buildCategoryCard(
                context,
                categoryName,
                categoryImageUrl,
                categoryDoc.id,
                index,
                menuController,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    String title,
    String imageUrl,
    String categoryId,
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
                  child: imageUrl.isNotEmpty
                      ? Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            );
                          },
                          errorBuilder: (c, e, s) => _buildDefaultIcon(),
                        )
                      : _buildDefaultIcon(),
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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

            // Action Button - PopupMenu System Fixed
            PopupMenuButton<String>(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              icon: const Icon(Icons.more_vert_rounded, color: Colors.grey),
              onSelected: (value) {
                if (value == 'view') {
                  controller.setCategoryIndex(index);
                  Get.toNamed(RouteName.VIEW_DETAILS);
                } else if (value == 'edit') {
                  // Comment output sorano holo ebong dynamic validation order sequence path map kora holo
                  showImagePickerBottomSheet(context, categoryId, title);
                } else if (value == 'delete') {
                  // Controller core execution model direct bind dynamic handler injection
                  showMenuDeleteDialog(context, categoryId, title);
                }
              },
              itemBuilder: (context) => [
                _buildPopupItem(
                  'view',
                  Icons.visibility_rounded,
                  'View Details',
                ),
                _buildPopupItem('edit', Icons.edit_rounded, 'Rename'),
                _buildPopupItem(
                  'delete',
                  Icons.delete_rounded,
                  'Delete',
                  isDelete: true,
                ),
              ],
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultIcon() {
    return Icon(
      Icons.fastfood_rounded,
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
