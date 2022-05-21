import 'package:admin_panel/controllers/navigation_controller.dart';
import 'package:admin_panel/views/sections/navigation_menu.dart';
import 'package:admin_panel/views/widgets/navigation_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 800) {
            return Scaffold(
              drawer: Drawer(
                width: constraints.maxWidth * .5,
                child: GetBuilder<NavigationController>(
                  builder: (controller) {
                    int currentIndex = controller.currentIndex.value;
                    return ListView(
                      padding: const EdgeInsets.only(top: 30),
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
                          icon: Icons.person_rounded,
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
                          icon: Icons.shopping_cart,
                          onTap: (index) {
                            controller.updateIndex(index);
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
              appBar: AppBar(),
              body: GetBuilder<NavigationController>(
                builder: (controller) {
                  int currentIndex = controller.currentIndex.value;
                  return controller.screens[currentIndex];
                },
              ),
            );
          } else {
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
        },
      ),
    );
    // return LayoutBuilder(
    //   builder: (context, constraints) {
    //     if (constraints.maxWidth < 800) {
    //       return Scaffold(
    //         drawer: Drawer(
    //           width: constraints.maxWidth * .5,
    //           child: GetBuilder<NavigationController>(
    //             builder: (controller) {
    //               int currentIndex = controller.currentIndex.value;
    //               return ListView(
    //                 padding: const EdgeInsets.only(top: 30),
    //                 children: [
    //                   NavigationButton(
    //                     index: 0,
    //                     currentIndex: currentIndex,
    //                     title: "Products",
    //                     icon: Icons.list,
    //                     onTap: (index) {
    //                       controller.updateIndex(index);
    //                     },
    //                   ),
    //                   NavigationButton(
    //                     index: 1,
    //                     currentIndex: currentIndex,
    //                     title: "Users",
    //                     icon: Icons.person_rounded,
    //                     onTap: (index) {
    //                       controller.updateIndex(index);
    //                     },
    //                   ),
    //                   NavigationButton(
    //                     index: 2,
    //                     currentIndex: currentIndex,
    //                     title: "Orders",
    //                     icon: Icons.shopping_cart,
    //                     onTap: (index) {
    //                       controller.updateIndex(index);
    //                     },
    //                   ),
    //                   NavigationButton(
    //                     index: 3,
    //                     currentIndex: currentIndex,
    //                     title: "Events",
    //                     icon: Icons.shopping_cart,
    //                     onTap: (index) {
    //                       controller.updateIndex(index);
    //                     },
    //                   ),
    //                 ],
    //               );
    //             },
    //           ),
    //         ),
    //         appBar: AppBar(),
    //         body: GetBuilder<NavigationController>(
    //           builder: (controller) {
    //             int currentIndex = controller.currentIndex.value;
    //             return controller.screens[currentIndex];
    //           },
    //         ),
    //       );
    //     } else {
    //       return Scaffold(
    //         body: Row(
    //           children: [
    //             const NavigationMenu(),
    //             GetBuilder<NavigationController>(
    //               builder: (controller) {
    //                 int currentIndex = controller.currentIndex.value;
    //                 return Expanded(
    //                   child: controller.screens[currentIndex],
    //                 );
    //               },
    //             ),
    //           ],
    //         ),
    //         floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
    //         floatingActionButton: FloatingActionButton(
    //           onPressed: () async => await FirebaseAuth.instance.signOut(),
    //           child: const Icon(Icons.logout),
    //           tooltip: "Logout",
    //         ),
    //       );
    //     }
    //   },
    // );
  }
}
