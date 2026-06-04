import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../domain/controller/menu_controller.dart';
import '../../../common_widget/custom_app_bar.dart';
import '../../../common_widget/custom_text_field.dart';
import '../../../const/app_const_dimensions.dart';
import '../../../const/app_const_theme.dart';
import '../../../const/styles.dart';

class AddMenuScreen extends StatelessWidget {
  const AddMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MyMenuController controller = Get.find<MyMenuController>();
    final TextEditingController nameController = TextEditingController();

    // Screen load hobar somoy purono image thakle clear korbe
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.clearPickedImage();
    });

    return Scaffold(
      backgroundColor: AppConstColor.backgroundGray,
      appBar: const CustomAppBar(title: "Add Menu"),
      body: GetBuilder<MyMenuController>(
        builder: (menuController) {
          return Padding(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            child: Column(
              children: [
                // Image Upload Container Area
                GestureDetector(
                  onTap: () =>
                      _showMediaOptionsBottomSheet(context, menuController),
                  child: Stack(
                    children: [
                      Container(
                        height: 220,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            style: menuController.pickedImage == null
                                ? BorderStyle.solid
                                : BorderStyle.none,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: menuController.pickedImage != null
                              ? Image.file(
                                  menuController.pickedImage!,
                                  fit: BoxFit.cover,
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.cloud_upload_outlined,
                                      size: 50,
                                      color: Colors.grey.shade400,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Upload Menu Image",
                                      style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      Positioned(
                        bottom: 12,
                        right: 12,
                        child: CircleAvatar(
                          backgroundColor: AppConstColor.primaryColor,
                          radius: 18,
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),

                // Name Input Form
                CustomTextField(
                  header: "Name",
                  hintText: "Enter your menu name",
                  controller: nameController,
                ),

                const Spacer(),

                // Save Dynamic Execution Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: menuController.isLoading.value
                        ? null
                        : () {
                            if (nameController.text.trim().isEmpty) {
                              Get.snackbar(
                                "Warning",
                                "Please enter a menu name",
                              );
                              return;
                            }

                            // Mock network URL path mapping deployment
                            String mockUrlPath =
                                menuController.pickedImage != null
                                ? "https://images.unsplash.com/photo-1568901346375-23c9450c58cd"
                                : "";

                            menuController.createCategory(
                              nameController.text,
                              mockUrlPath,
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstColor.primaryColor,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: menuController.isLoading.value
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            "Save",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showMediaOptionsBottomSheet(
    BuildContext context,
    MyMenuController controller,
  ) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Select Image Source", style: headline(context)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildOptionTile(
                  context,
                  icon: Icons.camera_alt,
                  label: "Camera",
                  color: Colors.blue,
                  onTap: () {
                    Get.back();
                    controller.pickImage(ImageSource.camera);
                  },
                ),
                _buildOptionTile(
                  context,
                  icon: Icons.photo_library,
                  label: "Gallery",
                  color: Colors.purple,
                  onTap: () {
                    Get.back();
                    controller.pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: color, size: 30),
          ),
          const SizedBox(height: 8),
          Text(label, style: bodyMedium(context)),
        ],
      ),
    );
  }
}
