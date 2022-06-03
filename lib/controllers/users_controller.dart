import 'dart:convert';

import 'package:admin_panel/models/user.dart';
import 'package:admin_panel/views/widgets/error_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UsersController extends GetxController {
  final CollectionReference<Map<String, dynamic>> _ref = FirebaseFirestore.instance.collection("users");

  RxString email = "".obs;

  void query(String value) {
    email.value = value;
    update();
  }

  Future<List<Users>> getUsers() async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = [];
    try {
      final data = await _ref.limit(50).get();
      docs = data.docs;
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }

    List<Users> users = [];
    for (var doc in docs) {
      users.add(Users.fromJson(doc.data(), uid: doc.id));
    }
    return users;
  }

  void sendGift(Users user, int points) async {
    try {
      // add the points
      await _ref.doc(user.id).update({
        "points": user.points + points
      });

      await http.post(
        Uri.parse("https://europe-west1-fenwicks-pub.cloudfunctions.net/sendNotification"),
        body: {
          "amount": points,
          "token": user.token
        },
      );
    } on FirebaseException catch (e) {
      Get.back();
      Get.showSnackbar(errorCard(e.message!));
    }
    Get.back();
  }
}
