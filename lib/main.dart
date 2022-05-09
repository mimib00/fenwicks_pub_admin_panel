import 'package:admin_panel/controllers/auth_controller.dart';
import 'package:admin_panel/controllers/bindings.dart';
import 'package:admin_panel/utils/constants.dart';
import 'package:admin_panel/views/home.dart';
import 'package:admin_panel/views/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyB6rOQS7jZhVWmf77moXzv2Lj9Y-si0T28",
      appId: "1:968413471908:web:71502288e3cc8deea27231",
      messagingSenderId: "968413471908",
      projectId: "fenwicks-pub",
      measurementId: "G-6HF95T836J",
      storageBucket: "fenwicks-pub.appspot.com",
      authDomain: "fenwicks-pub.firebaseapp.com",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen(
      (user) {
        final auth = Get.put(Auth());
        if (user != null) {
          if (auth.checkUserIsAdmin(user)) {
            Get.to(() => const HomeScreen());
          }
        } else {
          Get.to(() => LoginScreen());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: Binds(),
      title: 'Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: kBackgroundColor,
      ),
      home: Container(),
    );
  }
}
