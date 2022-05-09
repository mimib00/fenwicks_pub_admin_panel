import 'package:get/get.dart';

import 'navigation_controller.dart';
import 'auth_controller.dart';

class Binds extends Bindings {
  @override
  void dependencies() {
    Get.put(Auth());
    Get.put(NavigationController());
  }
}
