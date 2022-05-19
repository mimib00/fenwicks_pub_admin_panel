import 'package:admin_panel/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Align(
            alignment: Alignment.center,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                width: constraints.maxWidth * .2,
                // height: Get.height * .3,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Fenwicks Pub Admin Panel",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    const SizedBox(height: 50),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: email,
                            decoration: const InputDecoration(
                              hintText: "Email",
                              label: Text("Email"),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) return "Must provide an email";
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: password,
                            decoration: const InputDecoration(
                              hintText: "Password",
                              label: Text("Password"),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) return "Must provide a password";
                              return null;
                            },
                            onFieldSubmitted: (value) {
                              final Auth auth = Get.put(Auth());
                              if (_formKey.currentState!.validate()) {
                                auth.login(email.text.trim(), password.text.trim());
                              }
                            },
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              final Auth auth = Get.put(Auth());
                              if (_formKey.currentState!.validate()) {
                                auth.login(email.text.trim(), password.text.trim());
                              }
                            },
                            child: const Text("Login"),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
