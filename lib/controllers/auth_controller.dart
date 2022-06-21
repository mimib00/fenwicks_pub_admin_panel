import 'package:admin_panel/views/home.dart';
import 'package:admin_panel/views/login.dart';
import 'package:admin_panel/views/widgets/error_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class Auth extends GetxController {
  final CollectionReference<Map<String, dynamic>> _ref = FirebaseFirestore.instance.collection("admins");
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  /// Login the user and create a session.
  void login(String email, String password) async {
    try {
      final admin = await _ref.get();
      if (admin.docs.isEmpty) {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        _ref.doc(credential.user!.uid).set({"email": credential.user!.email!});
      } else {
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      }
    } on FirebaseAuthException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }
  }

  void checkAdminExists() async {
    try {} catch (e) {
      Get.showSnackbar(errorCard(e.toString()));
    }
  }

  /// Check [user] email is the same as the admin email
  ///
  /// and return True or False.
  Future<bool> checkUserIsAdmin(User user) async {
    bool isAdmin = false;
    try {
      // isAdmin = user.email == "test@test.com";

      final admins = await _ref.get();
      if (admins.docs.isEmpty) {
        throw "There is no admin";
      } else {
        final admin = admins.docs.first.data()["email"];
        isAdmin = user.email == admin;
        if (!isAdmin) {
          throw "User not Authorized";
        }
      }
    } catch (e) {
      Get.showSnackbar(errorCard(e.toString()));
    }
    return isAdmin;
  }

  Future<void> updateAdminToken(String email, String token) async {
    try {
      final snap = await _ref.where("email", isEqualTo: email).get();
      final admin = snap.docs.first;
      await _ref.doc(admin.id).set({"token": token}, SetOptions(merge: true));
    } on FirebaseAuthException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }
  }

  /// Logout currently logged user.
  void logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  void onInit() {
    FirebaseAuth.instance.authStateChanges().listen(
      (user) async {
        final auth = Get.put(Auth());
        if (user != null) {
          if (await auth.checkUserIsAdmin(user)) {
            final token = await messaging.getToken();
            await updateAdminToken(user.email!, token!);
            Get.to(() => const HomeScreen());
          } else {
            auth.logout();
          }
        } else {
          Get.to(() => LoginScreen());
        }
      },
    );
    super.onInit();
  }
}
