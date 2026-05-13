import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../domain/controller/profile_controller.dart';
import '../../../common_widget/custom_app_bar.dart';
import '../../../common_widget/custom_button.dart';
import '../../../common_widget/custom_text_field.dart';
import '../../../const/app_const_assets.dart';
import '../../../const/app_const_dimensions.dart';
import '../../../const/app_const_theme.dart';
import '../../../const/styles.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            title: "Restaurant Information",
            isBackButtonExist: true,
            centerTitle: true,
            // Apnar 'headline' style bebohar kora hoyeche
            titleStyle: headline(context),
          ),

          body: SingleChildScrollView(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                // Profile Image Selection Section
                Center(
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppConstColor.primaryColor.withOpacity(0.15),
                            width: 3,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 65,
                          backgroundColor: Colors.grey[50],
                          backgroundImage: controller.pickedImage != null
                              ? FileImage(controller.pickedImage!)
                              : const AssetImage(AppConstAssets.burger)
                                    as ImageProvider,
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: GestureDetector(
                          onTap: () =>
                              _showImageSourceSheet(context, controller),
                          child: Container(
                            height: 36,
                            width: 36,
                            decoration: BoxDecoration(
                              color: AppConstColor.primaryColor,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),

                // Apnar 'CustomTextField' e automatic 'header' style apply kora ache
                CustomTextField(
                  header: "Restaurant Name",
                  hintText: "Enter your restaurant name",
                  controller: TextEditingController(
                    text: controller.name.value,
                  ),
                  isRequired: true,
                  inputType: TextInputType.name,
                ),
                const SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

                CustomTextField(
                  header: "Phone Number",
                  hintText: "Enter phone number",
                  isRequired: true,
                  inputType: TextInputType.phone,
                ),
                const SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

                CustomTextField(
                  header: "Email Address",
                  hintText: "Enter email address",
                  isRequired: true,
                  inputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

                CustomTextField(
                  header: "Location",
                  hintText: "Enter restaurant location",
                  isRequired: true,
                  maxLines: 3,
                  inputAction: TextInputAction.done,
                ),

                const SizedBox(height: 50),
              ],
            ),
          ),

          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            child: ElevatedButton(
              onPressed: () {
                // Save button action
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Save"),
            ),
          ),
        );
      },
    );
  }

  void _showImageSourceSheet(
    BuildContext context,
    ProfileController controller,
  ) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(Dimensions.RADIUS_LARGE),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Choose Image Source",
              // Ekhane 'headline' use kora hoyeche bold look-er jonno
              style: headline(context),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _sourceOption(
                  context: context,
                  icon: Icons.camera_alt,
                  label: "Camera",
                  onTap: () {
                    controller.pickImage(ImageSource.camera);
                  },
                ),
                _sourceOption(
                  context: context,
                  icon: Icons.image,
                  label: "Gallery",
                  onTap: () {
                    controller.pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
            const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
          ],
        ),
      ),
    );
  }

  Widget _sourceOption({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: AppConstColor.primaryColor.withOpacity(0.1),
            child: Icon(icon, color: AppConstColor.primaryColor, size: 28),
          ),
          const SizedBox(height: 10),
          // Ekhane 'bodyMedium' bebohar kora hoyeche
          Text(label, style: bodyMedium(context)),
        ],
      ),
    );
  }
}
