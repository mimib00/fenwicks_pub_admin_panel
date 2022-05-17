import 'package:admin_panel/views/home.dart';
import 'package:admin_panel/views/login.dart';
import 'package:admin_panel/views/widgets/error_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Auth extends GetxController {
  /// Login the user and create a session.
  void login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }
  }

  /// Check [user] email is the same as the admin email
  ///
  /// and return True or False.
  //TODO: make the email fetched from firestore.
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

  /// Logout currently logged user.
  void logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  void onInit() {
    FirebaseAuth.instance.authStateChanges().listen(
      (user) {
        final auth = Get.put(Auth());
        if (user != null) {
          if (auth.checkUserIsAdmin(user)) {
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
