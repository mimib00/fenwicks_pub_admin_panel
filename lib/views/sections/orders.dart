import 'package:admin_panel/controllers/order_controller.dart';
import 'package:admin_panel/models/order.dart';
import 'package:admin_panel/models/user.dart';
import 'package:admin_panel/views/grids/order_grid.dart';
import 'package:admin_panel/views/widgets/error_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  Future<List<Order>> getOwner(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) async {
    List<Order> orders = [];
    try {
      for (var doc in docs) {
        DocumentReference<Map<String, dynamic>> ref = doc.data()["owner"];
        final temp = await ref.get();
        final user = Users.fromJson(temp.data()!, uid: temp.id);
        var map = doc.data();
        map["owner"] = user;
        orders.add(Order.fromJson(map, doc.id));
      }
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }
    return orders;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      init: OrderController(),
      builder: (controller) {
        return Container(
          alignment: Alignment.topCenter,
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: controller.getOrders(),
            builder: (context, snapshot) {
              if (snapshot.data == null || snapshot.data!.docs.isEmpty) return Container();
              return FutureBuilder<List<Order>>(
                future: getOwner(snapshot.data!.docs),
                builder: (context, snapshot) {
                  if (snapshot.data == null || snapshot.data!.isEmpty) return Container();
                  return OrderDataGrid(
                    title: "All Events",
                    orders: snapshot.data!,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
