import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../domain/controller/menu_controller.dart';
import '../../../common_widget/custom_app_bar.dart';
import '../../../common_widget/custom_text_field.dart';
import '../../../const/app_const_dimensions.dart';
import '../../../const/app_const_theme.dart';
import '../../../const/styles.dart';

class AddFoodScreen extends StatefulWidget {
  final String categoryId;
  final String categoryName;

  const AddFoodScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  bool isPopularItem = false;

  @override
  void initState() {
    super.initState();

    // Update image preview
    imageUrlController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    imageUrlController.dispose();
    nameController.dispose();
    priceController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MyMenuController controller = Get.find<MyMenuController>();

    return Scaffold(
      backgroundColor: AppConstColor.backgroundGray,
      appBar: CustomAppBar(title: "Add Food to ${widget.categoryName}"),
      body: GetBuilder<MyMenuController>(
        builder: (foodController) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image preview
                Text(
                  "Food Image Preview",
                  style: bodyMedium(
                    context,
                  )?.copyWith(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: imageUrlController.text.trim().isNotEmpty
                        ? Image.network(
                            imageUrlController.text.trim(),
                            fit: BoxFit.cover,
                            errorBuilder: (c, e, s) => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.broken_image_outlined,
                                  size: 45,
                                  color: Colors.redAccent,
                                ),

                                const SizedBox(height: 8),

                                Text(
                                  "Invalid Image URL Connection!",
                                  style: TextStyle(color: Colors.red[400]),
                                ),
                              ],
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image_search_rounded,
                                size: 45,
                                color: Colors.grey[400],
                              ),

                              const SizedBox(height: 8),

                              Text(
                                "Enter URL below to see preview",
                                style: TextStyle(color: Colors.grey[500]),
                              ),
                            ],
                          ),
                  ),
                ),

                const SizedBox(height: 20),

                // Food name
                CustomTextField(
                  header: "Food Name *",
                  hintText: "e.g., Crispy Chicken Fry",
                  controller: nameController,
                ),

                const SizedBox(height: 16),

                // Price
                CustomTextField(
                  header: "Price (৳) *",
                  hintText: "e.g., 450",
                  controller: priceController,
                  inputType: TextInputType.number,
                ),

                const SizedBox(height: 16),

                // Image url
                CustomTextField(
                  header: "Food Image URL *",
                  hintText: "https://example.com/image.jpg",
                  controller: imageUrlController,
                  inputType: TextInputType.url,
                ),

                const SizedBox(height: 16),

                // Description
                CustomTextField(
                  header: "Description *",
                  hintText: "Enter food descriptions...",
                  controller: descController,
                ),

                const SizedBox(height: 20),

                // Popular switch
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Mark as Popular",
                            style: bodyMedium(
                              context,
                            )?.copyWith(fontWeight: FontWeight.bold),
                          ),

                          Text(
                            "It will feature on popular list",
                            style: caption(context),
                          ),
                        ],
                      ),

                      Switch.adaptive(
                        activeColor: AppConstColor.primaryColor,
                        value: isPopularItem,
                        onChanged: (val) {
                          setState(() {
                            isPopularItem = val;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Save button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: foodController.isLoading.value
                        ? null
                        : () {
                            if (nameController.text.trim().isEmpty) {
                              Get.snackbar(
                                "Required Field",
                                "Food Name cannot be empty",
                                backgroundColor: Colors.amber,
                                colorText: Colors.black,
                              );

                              return;
                            }

                            if (priceController.text.trim().isEmpty) {
                              Get.snackbar(
                                "Required Field",
                                "Price field is mandatory",
                                backgroundColor: Colors.amber,
                                colorText: Colors.black,
                              );

                              return;
                            }

                            if (imageUrlController.text.trim().isEmpty) {
                              Get.snackbar(
                                "Required Field",
                                "Please paste or enter a valid Image URL Link",
                                backgroundColor: Colors.amber,
                                colorText: Colors.black,
                              );

                              return;
                            }

                            if (descController.text.trim().isEmpty) {
                              Get.snackbar(
                                "Required Field",
                                "Please write a short description",
                                backgroundColor: Colors.amber,
                                colorText: Colors.black,
                              );

                              return;
                            }

                            // Create food item
                            foodController.createFoodItem(
                              categoryId: widget.categoryId,
                              name: nameController.text,
                              price: priceController.text,
                              description: descController.text,
                              isPopular: isPopularItem,
                              finalImageUrl: imageUrlController.text.trim(),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstColor.primaryColor,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: foodController.isLoading.value
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            "Add Food Item",
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
}
