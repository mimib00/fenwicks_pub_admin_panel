import 'package:admin_panel/models/order.dart';
import 'package:admin_panel/models/user.dart';
import 'package:admin_panel/views/widgets/error_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final CollectionReference<Map<String, dynamic>> _ref = FirebaseFirestore.instance.collection("orders");
  RxString showPending = 'all'.obs;

  void changeFilter(String filter) {
    showPending.value = filter;
    update();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? getOrders() {
    Stream<QuerySnapshot<Map<String, dynamic>>>? snap;
    try {
      if (showPending.value == "pending") {
        snap = _ref.where("status", isEqualTo: "pending").orderBy("created_at", descending: true).snapshots();
      } else if (showPending.value == "onroute") {
        snap = _ref.where("status", isEqualTo: "on route").orderBy("created_at", descending: true).snapshots();
      } else if (showPending.value == "deliverd") {
        snap = _ref.where("status", isEqualTo: "deliverd").orderBy("created_at", descending: true).snapshots();
      } else {
        snap = _ref.orderBy("created_at", descending: true).snapshots();
      }
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }

    return snap;
  }

  void changeStatus(String status, String id, bool delete) async {
    try {
      await _ref.doc(id).set({"status": status}, SetOptions(merge: true));
      if (delete) {
        final snap = await FirebaseFirestore.instance.collection("admins").get();
        final admin = snap.docs.first;
        await FirebaseFirestore.instance.collection("admins").doc(admin.id).set({
          "notifications": FieldValue.arrayRemove([id])
        }, SetOptions(merge: true));
      }
      Get.back();
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }
  }

  Future<Order> getOrder(String id) async {
    DocumentSnapshot<Map<String, dynamic>>? doc;
    Users? user;
    try {
      doc = await _ref.doc(id).get();
      DocumentReference<Map<String, dynamic>> ref = doc.data()!["owner"];
      final temp = await ref.get();
      user = Users.fromJson(temp.data()!, uid: temp.id);
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }
    var map = doc!.data()!;
    map["owner"] = user;
    return Order.fromJson(map, id);
  }
}
