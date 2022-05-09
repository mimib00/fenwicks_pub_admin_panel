import 'package:admin_panel/controllers/navigation_controller.dart';
import 'package:admin_panel/views/sections/navigation_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const NavigationMenu(),
          GetBuilder<NavigationController>(
            builder: (controller) {
              int currentIndex = controller.currentIndex.value;
              return Expanded(
                child: controller.screens[currentIndex],
              );
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await FirebaseAuth.instance.signOut(),
        child: const Icon(Icons.logout),
        tooltip: "Logout",
      ),
    );
  }
}
