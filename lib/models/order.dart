import 'package:admin_panel/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  final String id;
  final String address;
  final Timestamp createdAt;
  final String method;
  final Users owner;
  final String status;
  final double total;
  final List products;

  Order(
    this.id,
    this.address,
    this.createdAt,
    this.method,
    this.owner,
    this.status,
    this.total,
    this.products,
  );

  factory Order.fromJson(Map<String, dynamic> data, String id) {
    return Order(
      id,
      data["address"],
      data['created_at'],
      data['method'],
      data['owner'],
      data['status'],
      data['total'],
      data['products'],
    );
  }

  Map<String, dynamic> toMap() => {
        "owner": owner,
        "created_at": createdAt,
        "address": address,
        "method": method,
        "status": status,
        "total": total,
        "products": products,
      };
}

/*{
        "owner": FirebaseFirestore.instance.collection("users").doc(user.id),
        "created_at": FieldValue.serverTimestamp(),
        "address": address,
        "method": "Cash on Delivery",
        "status": "pending",
        "total": getCartTotal(),
        "products": items,
      }*/