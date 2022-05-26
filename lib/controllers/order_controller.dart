import 'package:admin_panel/views/widgets/error_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final CollectionReference<Map<String, dynamic>> _ref = FirebaseFirestore.instance.collection("orders");
  RxBool showPending = false.obs;

  void changeFilter() {
    showPending.value = !showPending.value;
    update();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? getOrders() {
    Stream<QuerySnapshot<Map<String, dynamic>>>? snap;
    try {
      if (showPending.value) {
        snap = _ref.where("status", isEqualTo: "pending").orderBy("created_at", descending: true).snapshots();
      } else {
        snap = _ref.orderBy("created_at", descending: true).snapshots();
      }
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }

    return snap;
  }

  void changeStatus(String status, String id) async {
    try {
      await _ref.doc(id).set({
        "status": status
      }, SetOptions(merge: true));
      Get.back();
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }
  }
}
