import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../domain/controller/menu_controller.dart';
import '../../../common_widget/custom_app_bar.dart';
import '../../../common_widget/custom_text_field.dart';
import '../../../const/app_const_dimensions.dart';
import '../../../const/app_const_theme.dart';
import '../../../const/styles.dart';

class FoodDetailsScreen extends StatefulWidget {
  final String categoryId;
  final String foodId;
  final Map<String, dynamic> foodData;

  const FoodDetailsScreen({
    super.key,
    required this.categoryId,
    required this.foodId,
    required this.foodData,
  });

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final String restaurantId = 'C8ESI8GgEOLG2jMYcuET';

    return Scaffold(
      backgroundColor: AppConstColor.backgroundGray,
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('restaurants')
            .doc(restaurantId)
            .collection('categories')
            .doc(widget.categoryId)
            .collection('foods')
            .doc(widget.foodId)
            .snapshots(),
        builder: (context, snapshot) {
          // Loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          // Empty state
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Scaffold(
              appBar: const CustomAppBar(title: "Food Details"),
              body: Center(
                child: Text(
                  "Food item no longer exists.",
                  style: bodyMedium(context)?.copyWith(color: Colors.grey),
                ),
              ),
            );
          }

          var foodData = snapshot.data!.data() as Map<String, dynamic>;

          String currentName = foodData['foodName'] ?? "Unknown";

          String currentPrice = foodData['price']?.toString() ?? "0";

          String currentDesc =
              foodData['description'] ?? "No Description provided.";

          String currentUrl = foodData['foodImage'] ?? "";

          bool isPopular = foodData['isPopular'] ?? false;

          double rating = (foodData['ratting'] ?? 0.0).toDouble();

          return Scaffold(
            backgroundColor: AppConstColor.backgroundGray,
            appBar: CustomAppBar(
              title: currentName,
              centerTitle: true,
              isBackButtonExist: true,
              menuWidget: PopupMenuButton<String>(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                icon: const Icon(
                  Icons.more_vert_rounded,
                  color: Colors.black87,
                ),
                onSelected: (val) {
                  if (val == 'edit') {
                    _showEditFoodBottomSheet(
                      context,
                      currentName,
                      currentPrice,
                      currentDesc,
                      currentUrl,
                      isPopular,
                    );
                  } else if (val == 'delete') {
                    _showDeleteConfirmationDialog(context);
                  }
                },
                itemBuilder: (ctx) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit_rounded, size: 18),
                        SizedBox(width: 10),
                        Text("Edit Food"),
                      ],
                    ),
                  ),

                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete_forever_rounded,
                          color: Colors.red,
                          size: 18,
                        ),
                        SizedBox(width: 10),
                        Text("Delete", style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Food image
                  Container(
                    height: 230,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: currentUrl.isNotEmpty
                          ? Image.network(
                              currentUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (c, e, s) => const Icon(
                                Icons.broken_image_rounded,
                                size: 60,
                                color: Colors.grey,
                              ),
                            )
                          : const Icon(
                              Icons.fastfood_rounded,
                              size: 60,
                              color: Colors.grey,
                            ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Name and price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          currentName,
                          style: headline(context)?.copyWith(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),

                      Text(
                        "৳$currentPrice",
                        style: headline(context)?.copyWith(
                          color: AppConstColor.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Rating and popular
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 16,
                            ),

                            Text(
                              " ${rating.toStringAsFixed(1)} Rating",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 12),

                      if (isPopular)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            "🔥 Popular Item",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                    ],
                  ),

                  const Divider(height: 40, thickness: 1),

                  // Description title
                  Text(
                    "Description",
                    style: bodyMedium(
                      context,
                    )?.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                  ),

                  const SizedBox(height: 8),

                  // Description text
                  Text(
                    currentDesc,
                    style: bodyMedium(
                      context,
                    )?.copyWith(color: Colors.grey.shade600, height: 1.5),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Edit bottom sheet
  void _showEditFoodBottomSheet(
    BuildContext context,
    String name,
    String price,
    String desc,
    String url,
    bool popState,
  ) {
    final TextEditingController editNameCtrl = TextEditingController(
      text: name,
    );

    final TextEditingController editPriceCtrl = TextEditingController(
      text: price,
    );

    final TextEditingController editDescCtrl = TextEditingController(
      text: desc,
    );

    final TextEditingController editUrlCtrl = TextEditingController(text: url);

    bool editIsPopular = popState;

    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setModalState) {
          // Update image preview
          editUrlCtrl.addListener(() {
            if (context.mounted) {
              setModalState(() {});
            }
          });

          return Obx(() {
            final menuController = Get.find<MyMenuController>();

            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    Center(
                      child: Text(
                        "Update Food Details",
                        style: headline(context),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Preview image
                    Container(
                      height: 110,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: editUrlCtrl.text.trim().isNotEmpty
                            ? Image.network(
                                editUrlCtrl.text.trim(),
                                fit: BoxFit.cover,
                                errorBuilder: (c, e, s) => const Center(
                                  child: Text("⚠️ Image Connection URL error!"),
                                ),
                              )
                            : const Center(
                                child: Icon(Icons.image_search, size: 30),
                              ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Food name
                    CustomTextField(
                      header: "Food Name ",
                      hintText: "Name",
                      controller: editNameCtrl,
                    ),

                    const SizedBox(height: 12),

                    // Price
                    CustomTextField(
                      header: "Price ",
                      hintText: "Price",
                      controller: editPriceCtrl,
                      inputType: TextInputType.number,
                    ),

                    const SizedBox(height: 12),

                    // Image url
                    CustomTextField(
                      header: "Food Image URL ",
                      hintText: "Paste target Image network link",
                      controller: editUrlCtrl,
                      inputType: TextInputType.url,
                    ),

                    const SizedBox(height: 12),

                    // Description
                    CustomTextField(
                      header: "Description ",
                      hintText: "Write specifications",
                      controller: editDescCtrl,
                    ),

                    const SizedBox(height: 12),

                    // Popular switch
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Mark as Popular Item",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),

                        Switch.adaptive(
                          activeColor: AppConstColor.primaryColor,
                          value: editIsPopular,
                          onChanged: (v) {
                            setModalState(() => editIsPopular = v);
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Save button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: menuController.isLoading.value
                            ? null
                            : () async {
                                if (editNameCtrl.text.trim().isEmpty ||
                                    editPriceCtrl.text.trim().isEmpty ||
                                    editUrlCtrl.text.trim().isEmpty) {
                                  Get.snackbar(
                                    "Required",
                                    "All starred fields are mandatory",
                                  );

                                  return;
                                }

                                // Update food item
                                await menuController.editFoodItem(
                                  categoryId: widget.categoryId,
                                  foodId: widget.foodId,
                                  name: editNameCtrl.text,
                                  price: editPriceCtrl.text,
                                  description: editDescCtrl.text,
                                  finalImageUrl: editUrlCtrl.text,
                                  isPopular: editIsPopular,
                                );

                                // Close bottom sheet
                                if (Navigator.canPop(context)) {
                                  Navigator.pop(context);
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConstColor.primaryColor,
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: menuController.isLoading.value
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                "Save Content Changes",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        },
      ),
      isScrollControlled: true,
    );
  }

  // Delete dialog
  void _showDeleteConfirmationDialog(BuildContext context) {
    final MyMenuController menuController = Get.find<MyMenuController>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return Obx(() {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Row(
              children: [
                Icon(Icons.warning_amber_rounded, color: Colors.red),
                SizedBox(width: 8),
                Text("Delete Food?"),
              ],
            ),
            content: menuController.isLoading.value
                ? const SizedBox(
                    height: 60,
                    child: Center(child: CircularProgressIndicator()),
                  )
                : const Text(
                    "Are you completely sure you want to permanently delete this specific food item?",
                  ),
            actions: menuController.isLoading.value
                ? null
                : [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(dialogContext);
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        // Delete food item
                        await menuController.deleteFoodItem(
                          categoryId: widget.categoryId,
                          foodId: widget.foodId,
                        );

                        // Close dialog
                        if (Navigator.canPop(dialogContext)) {
                          Navigator.pop(dialogContext);
                        }

                        // Back to list
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        "Delete permanently",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
          );
        });
      },
    );
  }
}
