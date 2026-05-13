import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../domain/controller/menu_controller.dart';
import '../../../common_widget/custom_app_bar.dart';
import '../../../const/app_const_assets.dart';
import '../../../const/app_const_dimensions.dart';
import '../../../const/app_const_theme.dart';
import '../../../const/styles.dart';

class ViewDetailsScreen extends StatelessWidget {
  const ViewDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller find kora hochhe (DI theke)
    final MenuController menuController = Get.find<MenuController>();

    return Scaffold(
      backgroundColor: AppConstColor.backgroundGray,
      appBar: const CustomAppBar(title: "View Details"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Chips (Selectable with GetBuilder)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: GetBuilder<MyMenuController>(
                builder: (controller) {
                  return Row(
                    children: controller.categories.asMap().entries.map((
                      entry,
                    ) {
                      int index = entry.key;
                      String tag = entry.value;
                      bool isSelected =
                          controller.selectedCategoryIndex == index;

                      return GestureDetector(
                        onTap: () => controller.setCategoryIndex(index),
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          child: Chip(
                            label: Text(tag),
                            backgroundColor: isSelected
                                ? AppConstColor.primaryColor
                                : Colors.white,
                            labelStyle: TextStyle(
                              color: isSelected ? Colors.white : Colors.grey,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                            shape: const StadiumBorder(),
                            side: BorderSide.none,
                            elevation: isSelected ? 2 : 0,
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            Text("Popular Food", style: headline(context)),
            const SizedBox(height: 12),
            _buildFoodGrid(context, count: 2),

            const SizedBox(height: 25),
            Text("All Foods", style: headline(context)),
            const SizedBox(height: 12),
            _buildFoodGrid(context, count: 6),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodGrid(BuildContext context, {required int count}) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 0.85,
      ),
      itemCount: count,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    AppConstAssets.burger,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Cheeseburger",
                      style: bodyMedium(
                        context,
                      )?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.orange, size: 14),
                        Text(" 4.8", style: caption(context)),
                        const Spacer(),
                        Text(
                          "৳12.50",
                          style: bodyMedium(context)?.copyWith(
                            color: AppConstColor.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
