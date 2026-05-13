import 'package:get/get.dart';

class MyMenuController extends GetxController {
  final List<String> categories = [
    "Zinger",
    "Veggi",
    "Checkin",
    "Him",
    "Cheese",
  ];

  int selectedCategoryIndex = 0;

  void setCategoryIndex(int index) {
    selectedCategoryIndex = index;
    update();
  }
}
