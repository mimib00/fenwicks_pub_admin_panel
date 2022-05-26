import 'package:admin_panel/controllers/order_controller.dart';
import 'package:admin_panel/models/order.dart';
import 'package:admin_panel/views/widgets/custom_button.dart';
import 'package:admin_panel/views/widgets/error_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderDetails extends StatelessWidget {
  final Order order;
  const OrderDetails({
    Key? key,
    required this.order,
  }) : super(key: key);

  Future<Map<String, dynamic>> getProductData(DocumentReference<Map<String, dynamic>> ref) async {
    DocumentSnapshot<Map<String, dynamic>>? doc;
    try {
      doc = await ref.get();
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }
    return doc!.data()!;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title("Order Number"),
              heading(order.id),
              title("Order Date"),
              heading(DateFormat.yMMMEd().format(order.createdAt.toDate())),
              const SizedBox(height: 8),
              title("Client Name"),
              heading(order.owner.name),
              title("Client Phone"),
              heading(order.owner.phone),
              const SizedBox(height: 8),
              title("Client Address"),
              heading(order.address),
              const SizedBox(height: 8),
              title("Payment Method"),
              heading(order.method),
              const SizedBox(height: 8),
              title("Total price"),
              heading("\$${order.total}"),
              title("Order"),
              ListView.builder(
                itemCount: order.products.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final product = order.products[index];
                  return FutureBuilder<Map<String, dynamic>>(
                    future: getProductData(product['product']),
                    builder: (context, snap) {
                      if (snap.data == null) return Container();
                      return Row(
                        children: [
                          heading(snap.data!["name"]),
                          Text("X ${product['quantity']}")
                        ],
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 50),
              GetBuilder<OrderController>(
                builder: (controller) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        icon: Icons.route,
                        title: "On Route",
                        onTap: () {
                          controller.changeStatus("on route", order.id);
                        },
                      ),
                      const SizedBox(width: 10),
                      CustomButton(
                        icon: Icons.check_rounded,
                        title: "Delivered",
                        onTap: () {
                          controller.changeStatus("delivered", order.id);
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text heading(String heading) {
    return Text(
      heading,
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 18,
        color: Colors.black,
        fontFamily: 'Poppins',
      ),
      overflow: TextOverflow.fade,

      // size: 18,
      // weight: FontWeight.w700,
      // overFlow: TextOverflow.fade,
      // fontFamily: 'Poppins',
    );
  }

  Widget title(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black,
          fontFamily: 'Poppins',
        ),
        overflow: TextOverflow.fade,
        // size: 14,
        // paddingBottom: 3,
        // fontFamily: 'Poppins',
      ),
    );
  }
}
