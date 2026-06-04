import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../domain/controller/menu_controller.dart';
import '../../../common_widget/custom_app_bar.dart';
import '../../../const/app_const_dimensions.dart';
import '../../../const/app_const_theme.dart';
import '../../../const/styles.dart';
import '../../menu/screen/add_food_screen.dart';
import '../../menu/screen/food_details_screen.dart';

class ViewDetailsScreen extends StatelessWidget {
  const ViewDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyMenuController>(
      builder: (controller) {
        if (controller.categoriesList.isEmpty) {
          return const Scaffold(
            appBar: CustomAppBar(title: "View Details"),
            body: Center(child: Text("No Categories Available")),
          );
        }

        DocumentSnapshot activeCategoryDoc =
            controller.categoriesList[controller.selectedCategoryIndex];

        Map<String, dynamic> activeData =
            activeCategoryDoc.data() as Map<String, dynamic>;

        String activeTitle = activeData['categoryName'] ?? "View Details";

        return Scaffold(
          backgroundColor: AppConstColor.backgroundGray,
          appBar: CustomAppBar(
            title: activeTitle,
            centerTitle: true,
            isBackButtonExist: true,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Get.to(
              () => AddFoodScreen(
                categoryId: activeCategoryDoc.id,
                categoryName: activeTitle,
              ),
            ),
            backgroundColor: AppConstColor.primaryColor,
            child: const Icon(
              Icons.add_to_photos_rounded,
              color: Colors.white,
              size: 26,
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              vertical: Dimensions.PADDING_SIZE_DEFAULT,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCategorySection(controller),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                  child: Text("Popular Food", style: headline(context)),
                ),
                const SizedBox(height: 12),
                _buildDynamicFoodStream(activeCategoryDoc.id, isPopular: true),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                  child: Text("All Foods", style: headline(context)),
                ),
                const SizedBox(height: 12),
                _buildDynamicFoodStream(activeCategoryDoc.id, isPopular: false),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDynamicFoodStream(String categoryId, {required bool isPopular}) {
    final String restaurantId = 'C8ESI8GgEOLG2jMYcuET';

    Query query = FirebaseFirestore.instance
        .collection('restaurants')
        .doc(restaurantId)
        .collection('categories')
        .doc(categoryId)
        .collection('foods');

    if (isPopular) {
      query = query.where('isPopular', isEqualTo: true);
    }

    return StreamBuilder<QuerySnapshot>(
      stream: query.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT,
              vertical: 10,
            ),
            child: Text(
              isPopular ? "Popular food not found" : "All food not found",
              style: bodyMedium(
                context,
              )?.copyWith(color: Colors.grey, fontStyle: FontStyle.italic),
            ),
          );
        }

        final foodDocs = snapshot.data!.docs;

        if (isPopular) {
          return SizedBox(
            height: 220,
            child: ListView.builder(
              padding: const EdgeInsets.only(
                left: Dimensions.PADDING_SIZE_DEFAULT,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: foodDocs.length,
              itemBuilder: (context, index) {
                var foodId = foodDocs[index].id;
                var foodData = foodDocs[index].data() as Map<String, dynamic>;

                return Container(
                  width: 170,
                  margin: const EdgeInsets.only(right: 15),
                  child: _buildFoodCard(context, categoryId, foodId, foodData),
                );
              },
            ),
          );
        }

        return Padding(
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
            itemCount: foodDocs.length,
            itemBuilder: (context, index) {
              var foodId = foodDocs[index].id;
              var foodData = foodDocs[index].data() as Map<String, dynamic>;

              return _buildFoodCard(context, categoryId, foodId, foodData);
            },
          ),
        );
      },
    );
  }

  Widget _buildFoodCard(
    BuildContext context,
    String categoryId,
    String foodId,
    Map<String, dynamic> foodData,
  ) {
    String foodName = foodData['foodName'] ?? "Unknown Food";
    String foodImageUrl = foodData['foodImage'] ?? "";
    String foodPrice = foodData['price']?.toString() ?? "0";
    double rating = (foodData['ratting'] ?? 0.0).toDouble();

    return GestureDetector(
      onTap: () => Get.to(
        () => FoodDetailsScreen(
          categoryId: categoryId,
          foodId: foodId,
          foodData: foodData,
        ),
      ),
      child: Container(
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
                  padding: const EdgeInsets.all(12),
                  child: foodImageUrl.isNotEmpty
                      ? Image.network(foodImageUrl, fit: BoxFit.cover)
                      : const Icon(Icons.fastfood_rounded),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    foodName,
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
                          const Icon(Icons.star, size: 14),
                          Text(" ${rating.toStringAsFixed(1)}"),
                        ],
                      ),
                      Text(
                        "৳$foodPrice",
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
      ),
    );
  }

  Widget _buildCategorySection(MyMenuController controller) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT),
      child: Row(
        children: controller.categoriesList.asMap().entries.map((entry) {
          int index = entry.key;
          DocumentSnapshot doc = entry.value;

          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

          String displayName = data['categoryName'] ?? "Unknown";
          bool isSelected = controller.selectedCategoryIndex == index;

          return GestureDetector(
            onTap: () => controller.setCategoryIndex(index),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? AppConstColor.primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                displayName,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black54,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
