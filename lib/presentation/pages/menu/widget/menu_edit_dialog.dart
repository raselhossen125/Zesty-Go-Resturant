// EDIT DIALOG
import 'package:flutter/material.dart';

import '../../../common_widget/custom_text_field.dart';
import '../../../const/app_const_assets.dart';
import '../../../const/app_const_theme.dart';
import '../../../const/styles.dart';

void showMenuEditDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Edit Menu Item", style: headline(context)),
          const SizedBox(height: 8),
          Text(
            "You can update the menu image and name from here.",
            textAlign: TextAlign.center,
            style: caption(context),
          ),
          const SizedBox(height: 20),
          // Image stack same as Add Menu but smaller
          Stack(
            children: [
              Container(
                height: 120,
                width: 180,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.asset(AppConstAssets.burger),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: AppConstColor.primaryColor,
                  child: const Icon(Icons.edit, size: 12, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const CustomTextField(
            header: "Name",
            hintText: "Enter your menu name",
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(shape: const StadiumBorder()),
                  child: const Text("Cancel"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstColor.primaryColor,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    "Update",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
