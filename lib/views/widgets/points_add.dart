import 'package:admin_panel/controllers/users_controller.dart';
import 'package:admin_panel/models/user.dart';
import 'package:admin_panel/views/widgets/custom_button.dart';
import 'package:admin_panel/views/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PointsDialog extends StatelessWidget {
  final Users user;
  PointsDialog({
    Key? key,
    required this.user,
  }) : super(key: key);

  int points = 0;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                hintText: "Gift ${user.name} some points",
                label: "Points",
                keyboardFormat: FilteringTextInputFormatter.digitsOnly,
                onChange: (value) {
                  points = int.parse(value);
                },
              ),
              GetBuilder<UsersController>(
                builder: (controller) {
                  return CustomButton(
                    icon: Icons.card_giftcard_rounded,
                    title: "Send Gift",
                    onTap: () {
                      controller.sendGift(user, points);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
