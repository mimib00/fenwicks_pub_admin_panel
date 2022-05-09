import 'package:admin_panel/views/widgets/error_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Auth extends GetxController {
  void login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }
  }

  bool checkUserIsAdmin(User user) {
    bool isAdmin = false;
    try {
      isAdmin = user.email == "test@test.com";
      if (!isAdmin) {
        throw "User not Authorized";
      }
    } catch (e) {
      Get.showSnackbar(errorCard(e.toString()));
    }
    return isAdmin;
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
