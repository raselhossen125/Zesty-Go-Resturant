import 'package:flutter/material.dart';

import '../../../common_widget/custom_app_bar.dart';
import '../../../common_widget/custom_text_field.dart';
import '../../../const/app_const_assets.dart';
import '../../../const/app_const_dimensions.dart';
import '../../../const/app_const_theme.dart';

class AddMenuScreen extends StatelessWidget {
  const AddMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstColor.backgroundGray,
      appBar: const CustomAppBar(title: "Add Menu"),
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        child: Column(
          children: [
            // Big Image Upload Area
            Stack(
              children: [
                Container(
                  height: 220,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(AppConstAssets.burger),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: CircleAvatar(
                    backgroundColor: AppConstColor.primaryColor,
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),

            // Input Field (Using your CustomTextField)
            const CustomTextField(
              header: "Name",
              hintText: "Enter your menu name",
            ),

            const Spacer(),

            // Save Button
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConstColor.primaryColor,
                shape: const StadiumBorder(),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                "Save",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
