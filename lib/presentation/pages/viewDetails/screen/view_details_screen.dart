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
    // Controller find
    final MyMenuController menuController = Get.find<MyMenuController>();

    return Scaffold(
      backgroundColor: AppConstColor.backgroundGray,
      appBar: const CustomAppBar(title: "View Details"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: Dimensions.PADDING_SIZE_DEFAULT,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Chips (Selectable)
            _buildCategorySection(),

            const SizedBox(height: 20),

            // Popular Food Header
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT,
              ),
              child: Text("Popular Food", style: headline(context)),
            ),
            const SizedBox(height: 12),

            // Horizontal Popular Foods
            SizedBox(
              height: 220, // Card-er height fix kora hoyeche
              child: ListView.builder(
                padding: const EdgeInsets.only(
                  left: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: 5, // Static count or controller list
                itemBuilder: (context, index) {
                  return Container(
                    width:
                        170, // Card-er width fix kora hoyeche horizontal scroll-er jonno
                    margin: const EdgeInsets.only(right: 15, bottom: 5, top: 5),
                    child: _buildFoodCard(context),
                  );
                },
              ),
            ),

            const SizedBox(height: 25),

            // All Foods Header
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT,
              ),
              child: Text("All Foods", style: headline(context)),
            ),
            const SizedBox(height: 12),

            // Vertical All Foods Grid
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT,
              ),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.82,
                ),
                itemCount: 6,
                itemBuilder: (context, index) => _buildFoodCard(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Common Food Card Widget
  Widget _buildFoodCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(AppConstAssets.burger, fit: BoxFit.contain),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Cheeseburger",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: bodyMedium(
                    context,
                  )?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.orange, size: 14),
                        Text(" 4.8", style: caption(context)),
                      ],
                    ),
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
  }

  Widget _buildCategorySection() {
    return GetBuilder<MyMenuController>(
      builder: (controller) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT),
          child: Row(
            children: controller.categoriesList.asMap().entries.map((entry) {
              int index = entry.key;
              String tag = entry.value.id;
              bool isSelected = controller.selectedCategoryIndex == index;

              return GestureDetector(
                onTap: () => controller.setCategoryIndex(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppConstColor.primaryColor
                        : Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: AppConstColor.primaryColor.withOpacity(
                                0.3,
                              ),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : [],
                    border: Border.all(
                      color: isSelected
                          ? AppConstColor.primaryColor
                          : Colors.grey.shade200,
                    ),
                  ),
                  child: Text(
                    tag,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey.shade600,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
