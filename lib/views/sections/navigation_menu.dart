import 'package:admin_panel/controllers/navigation_controller.dart';
import 'package:admin_panel/views/widgets/navigation_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({Key? key}) : super(key: key);

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(
      builder: (controller) {
        int currentIndex = controller.currentIndex.value;
        return Container(
          width: Get.width * .18,
          height: Get.height,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              NavigationButton(
                index: 0,
                currentIndex: currentIndex,
                title: "Products",
                icon: Icons.list,
                onTap: (index) {
                  controller.updateIndex(index);
                },
              ),
              NavigationButton(
                index: 1,
                currentIndex: currentIndex,
                title: "Users",
                icon: Icons.people_rounded,
                onTap: (index) {
                  controller.updateIndex(index);
                },
              ),
              NavigationButton(
                index: 2,
                currentIndex: currentIndex,
                title: "Orders",
                icon: Icons.shopping_cart,
                onTap: (index) {
                  controller.updateIndex(index);
                },
              ),
              NavigationButton(
                index: 3,
                currentIndex: currentIndex,
                title: "Events",
                icon: Icons.event_rounded,
                onTap: (index) {
                  controller.updateIndex(index);
                },
              ),
              NavigationButton(
                index: 4,
                currentIndex: currentIndex,
                title: "Notifications",
                icon: Icons.notification_add,
                onTap: (index) {
                  controller.updateIndex(index);
                },
              ),
              NavigationButton(
                index: 5,
                currentIndex: currentIndex,
                title: "New Orders",
                icon: Icons.shopping_cart_checkout_rounded,
                onTap: (index) {
                  controller.updateIndex(index);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
