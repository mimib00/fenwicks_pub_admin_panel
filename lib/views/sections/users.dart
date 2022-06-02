import 'package:admin_panel/controllers/users_controller.dart';
import 'package:admin_panel/models/user.dart';
import 'package:admin_panel/views/grids/users_grid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UsersController>(
      init: UsersController(),
      builder: (controller) {
        return Container(
          alignment: Alignment.topCenter,
          child: FutureBuilder<List<Users>>(
            future: controller.getUsers(),
            builder: (context, snapshot) {
              final data = snapshot.data ?? [].cast<Users>().toList();
              List<Users> query = controller.email.value.isNotEmpty ? data.where((user) => user.email.toLowerCase() == controller.email.value.toLowerCase()).toList() : data;
              return UsersDataGrid(
                users: query,
                title: "Users",
              );
            },
          ),
        );
      },
    );
  }
}
