import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../domain/controller/profile_controller.dart';
import '../../../common_widget/custom_app_bar.dart';
import '../../../common_widget/custom_text_field.dart';
import '../../../const/app_const_assets.dart';
import '../../../const/app_const_dimensions.dart';
import '../../../const/app_const_theme.dart';
import '../../../const/styles.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameCtrl;
  late TextEditingController phoneCtrl;
  late TextEditingController emailCtrl;
  late TextEditingController locationCtrl;
  late TextEditingController urlCtrl;

  @override
  void initState() {
    super.initState();

    final controller = Get.find<ProfileController>();

    // init profile data
    nameCtrl = TextEditingController(text: controller.profile?.name ?? '');
    phoneCtrl = TextEditingController(text: controller.profile?.phone ?? '');
    emailCtrl = TextEditingController(text: controller.profile?.email ?? '');
    locationCtrl = TextEditingController(
      text: controller.profile?.location ?? '',
    );
    urlCtrl = TextEditingController(text: controller.profile?.imageUrl ?? '');
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    phoneCtrl.dispose();
    emailCtrl.dispose();
    locationCtrl.dispose();
    urlCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Restaurant Information",
        isBackButtonExist: true,
        centerTitle: true,
        titleStyle: headline(context),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

            // Profile image
            Center(
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppConstColor.primaryColor.withOpacity(0.2),
                    width: 3,
                  ),
                ),
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[100],
                  backgroundImage: urlCtrl.text.trim().isNotEmpty
                      ? NetworkImage(urlCtrl.text.trim())
                      : const AssetImage(AppConstAssets.burger)
                            as ImageProvider,
                ),
              ),
            ),

            const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

            CustomTextField(
              header: "Restaurant Image URL",
              hintText: "Paste online image network link",
              controller: urlCtrl,
              inputType: TextInputType.url,
            ),

            const SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

            CustomTextField(
              header: "Restaurant Name ",
              hintText: "Enter restaurant name",
              controller: nameCtrl,
              isRequired: true,
            ),

            const SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

            CustomTextField(
              header: "Phone Number ",
              hintText: "Enter phone number",
              controller: phoneCtrl,
              isRequired: true,
              inputType: TextInputType.phone,
            ),

            const SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

            CustomTextField(
              header: "Email Address ",
              hintText: "Enter email address",
              controller: emailCtrl,
              isRequired: true,
              inputType: TextInputType.emailAddress,
            ),

            const SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

            CustomTextField(
              header: "Location",
              hintText: "Enter restaurant location",
              controller: locationCtrl,
              isRequired: false,
              maxLines: 3,
              inputAction: TextInputAction.done,
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),

      bottomNavigationBar: GetBuilder<ProfileController>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            child: ElevatedButton(
              onPressed: controller.isLoading
                  ? null
                  : () async {
                      if (nameCtrl.text.trim().isEmpty ||
                          phoneCtrl.text.trim().isEmpty ||
                          emailCtrl.text.trim().isEmpty) {
                        Get.snackbar(
                          "Required",
                          "Starred fields cannot be empty!",
                        );
                        return;
                      }

                      await controller.saveProfile(
                        newName: nameCtrl.text.trim(),
                        newPhone: phoneCtrl.text.trim(),
                        newEmail: emailCtrl.text.trim(),
                        newLocation: locationCtrl.text.trim(),
                        newImageUrl: urlCtrl.text.trim(),
                      );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConstColor.primaryColor,
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: controller.isLoading
                  ? const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                  : const Text(
                      "Save Changes",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
