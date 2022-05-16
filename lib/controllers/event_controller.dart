import 'package:admin_panel/models/event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../views/widgets/error_card.dart';

class EventController extends GetxController {
  final CollectionReference<Map<String, dynamic>> _ref = FirebaseFirestore.instance.collection("events");

  Future<bool> addEvent(Event event) async {
    try {
      await _ref.add(event.toMap());
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
      return false;
    }
    return true;
  }

  Future<List<Event>> getAllEvents() async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = [];
    try {
      final data = await _ref.get();
      docs = data.docs;
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }
    List<Event> events = [];
    for (var doc in docs) {
      events.add(Event.fromJson(doc.data(), uid: doc.id));
    }
    return events;
  }
}
