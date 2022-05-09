import 'package:admin_panel/views/sections/products.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  RxInt currentIndex = 0.obs;
  final List screens = [
    const ProductScreen()
  ];

  void updateIndex(int index) {
    currentIndex.value = index;
    update();
  }
}
