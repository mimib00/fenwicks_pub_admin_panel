import 'package:admin_panel/models/product.dart';
import 'package:admin_panel/views/widgets/error_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final CollectionReference<Map<String, dynamic>> _ref = FirebaseFirestore.instance.collection("products");

  Future<bool> addProduct(Product product) async {
    try {
      await _ref.add(product.toMap());
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
      return false;
    }
    return true;
  }

  Future<List<Product>> getAllProducts() async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = [];
    try {
      final data = await _ref.get();
      docs = data.docs;
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }

    List<Product> products = [];
    for (var doc in docs) {
      products.add(Product.fromJson(doc.data(), id: doc.id));
    }

    return products;
  }
}
