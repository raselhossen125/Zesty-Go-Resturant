import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../domain/controller/menu_controller.dart'; // Apnar controller path
import '../../../common_widget/custom_text_field.dart';
import '../../../const/app_const_theme.dart';
import '../../../const/styles.dart';

void showImagePickerBottomSheet(BuildContext context, String currentTitle) {
  final MyMenuController controller = Get.find<MyMenuController>();
  final TextEditingController nameController = TextEditingController(
    text: currentTitle,
  );

  Get.bottomSheet(
    GetBuilder<MyMenuController>(
      builder: (controller) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top Indicator
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),
              Text("Update Category", style: headline(context)),
              const SizedBox(height: 25),

              // Image Preview Area
              Center(
                child: Stack(
                  children: [
                    Container(
                      height: 110,
                      width: 110,
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppConstColor.primaryColor.withOpacity(0.1),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: controller.pickedImage != null
                            ? Image.file(
                                controller.pickedImage!,
                                fit: BoxFit.cover,
                              )
                            : Icon(
                                Icons.add_photo_alternate_outlined,
                                color: Colors.grey[400],
                                size: 40,
                              ),
                      ),
                    ),
                    if (controller.pickedImage != null)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () => controller.clearPickedImage(),
                          child: const CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.red,
                            child: Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              // Source Options
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildOptionCard(
                    context,
                    icon: Icons.camera_alt_rounded,
                    label: "Camera",
                    color: Colors.blue,
                    onTap: () => controller.pickImage(ImageSource.camera),
                  ),
                  _buildOptionCard(
                    context,
                    icon: Icons.photo_library_rounded,
                    label: "Gallery",
                    color: Colors.purple,
                    onTap: () => controller.pickImage(ImageSource.gallery),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              CustomTextField(
                header: "Menu Name",
                hintText: "Enter menu name",
                controller: nameController,
              ),
              const SizedBox(height: 30),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Ekhane save logic hobe (Database update)
                    Get.back();
                    controller.clearPickedImage();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstColor.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Save Changes",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    ),
    isScrollControlled: true,
  );
}

// Missing function-ti ekhane define kora holo
Widget _buildOptionCard(
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
        Text(label, style: bodyMedium(context)?.copyWith(fontSize: 14)),
      ],
    ),
  );
}
