import 'package:admin_panel/controllers/bindings.dart';
import 'package:admin_panel/utils/constants.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
