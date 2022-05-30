import 'package:admin_panel/views/sections/orders.dart';
import 'package:admin_panel/views/sections/rewards.dart';
import 'package:get/get.dart';

import '../views/sections/events.dart';
import '../views/sections/products.dart';

class NavigationController extends GetxController {
  RxInt currentIndex = 0.obs;
  final List screens = [
    ProductScreen(),
    RewardsScreen(),
    const OrderScreen(),
    EventScreen(),
  ];

  void updateIndex(int index) {
    currentIndex.value = index;
    update();
  }
}
