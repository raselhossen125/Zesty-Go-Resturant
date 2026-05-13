// DELETE DIALOG
import 'package:flutter/material.dart';

import '../../../const/app_const_theme.dart';
import '../../../const/styles.dart';

void showMenuDeleteDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Delete Menu Item", style: headline(context)),
          const SizedBox(height: 15),
          Text(
            "Are you sure you want to delete this menu item? This action cannot be undone.",
            textAlign: TextAlign.center,
            style: bodyMedium(context),
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
                    "Delete",
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
