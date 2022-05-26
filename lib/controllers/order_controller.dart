import 'package:admin_panel/views/widgets/error_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final CollectionReference<Map<String, dynamic>> _ref = FirebaseFirestore.instance.collection("orders");
  Stream<QuerySnapshot<Map<String, dynamic>>>? getOrders() {
    Stream<QuerySnapshot<Map<String, dynamic>>>? snap;
    try {
      snap = _ref.orderBy("created_at").snapshots();
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }
    return snap;
  }
}
