import 'package:admin_panel/views/widgets/custom_button.dart';
import 'package:admin_panel/views/widgets/custom_text_field.dart';
import 'package:admin_panel/views/widgets/error_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key);

  final TextEditingController title = TextEditingController();
  final TextEditingController body = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 20,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Send Notifications to all users",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Colors.black),
              ),
              Row(
                children: [
                  Expanded(child: CustomTextField(hintText: "Notification Title", label: "Title", controller: title)),
                  Expanded(child: CustomTextField(hintText: "Notification message", label: "Body", controller: body)),
                ],
              ),
              Row(
                children: [
                  CustomButton(
                    icon: Icons.add_rounded,
                    title: "Send",
                    onTap: () async {
                      try {
                        // send http request
                        final url =
                            Uri.parse("https://us-central1-fenwicks-pub-a46a5.cloudfunctions.net/sendNotifications");

                        final res = await http.post(
                          url,
                          body: {
                            "title": title.text.trim(),
                            "body": body.text.trim(),
                          },
                        );

                        // throw error
                        if (res.statusCode == 404) throw res.body;
                        // show status is good and clear fields
                        Get.showSnackbar(
                          const GetSnackBar(
                            duration: Duration(seconds: 3),
                            title: "Success",
                            messageText: Text(
                              "Notification has been sent",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: "Baloo",
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                        title.clear();
                        body.clear();
                      } catch (e) {
                        Get.showSnackbar(errorCard(e.toString()));
                      }
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
