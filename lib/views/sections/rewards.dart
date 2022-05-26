import 'package:admin_panel/controllers/rewards_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RewardsScreen extends StatelessWidget {
  RewardsScreen({Key? key}) : super(key: key);

  final RewardsController controller = Get.put(RewardsController());

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
    );
  }
}
