import 'package:admin_panel/views/sections/new_order.dart';
import 'package:admin_panel/views/sections/notification.dart';
import 'package:admin_panel/views/sections/orders.dart';
import 'package:admin_panel/views/sections/users.dart';
import 'package:get/get.dart';

import '../views/sections/events.dart';
import '../views/sections/products.dart';

class NavigationController extends GetxController {
  RxInt currentIndex = 0.obs;
  final List screens = [
    ProductScreen(),
    const UserScreen(),
    const OrderScreen(),
    EventScreen(),
    NotificationScreen(),
    const NewOrders(),
  ];

  void updateIndex(int index) {
    currentIndex.value = index;
    update();
  }
}
