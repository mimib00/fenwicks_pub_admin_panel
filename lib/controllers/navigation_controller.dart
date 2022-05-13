import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../views/sections/events.dart';
import '../views/sections/products.dart';

class NavigationController extends GetxController {
  RxInt currentIndex = 0.obs;
  final List screens = [
    ProductScreen(),
    Container(),
    Container(),
    EventScreen(),
  ];

  void updateIndex(int index) {
    currentIndex.value = index;
    update();
  }
}
