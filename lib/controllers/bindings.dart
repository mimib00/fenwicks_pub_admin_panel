import 'package:admin_panel/controllers/navigation_controller.dart';
import 'package:get/get.dart';

class Binds extends Bindings {
  @override
  void dependencies() {
    Get.put(NavigationController());
  }
}
