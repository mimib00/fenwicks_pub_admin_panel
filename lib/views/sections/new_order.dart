import 'package:admin_panel/controllers/order_controller.dart';
import 'package:admin_panel/views/widgets/order_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewOrders extends StatelessWidget {
  const NewOrders({Key? key}) : super(key: key);

  Stream<DocumentSnapshot<Map<String, dynamic>>> getNewOrders() {
    final admin = FirebaseAuth.instance.currentUser!;
    final CollectionReference<Map<String, dynamic>> _ref = FirebaseFirestore.instance.collection("admins");

    return _ref.doc(admin.uid).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 20,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "New Orders",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Colors.black),
              ),
              StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: getNewOrders(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) return Container();

                  final admin = snapshot.data!.data()!;
                  final List<String> orders = admin['notifications'].cast<String>() ?? [];

                  return ListView.builder(
                    itemCount: orders.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () async {
                          final OrderController controller = Get.put(OrderController());
                          final order = await controller.getOrder(orders[index]);
                          Get.dialog(OrderDetails(
                            order: order,
                            delete: true,
                          ));
                        },
                        enableFeedback: true,
                        horizontalTitleGap: 0,
                        leading: Text("${index + 1})"),
                        title: Text(orders[index]),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
