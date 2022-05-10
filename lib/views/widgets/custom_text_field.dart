import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/constants.dart';

class CustomTextField extends StatelessWidget {
  final String label, hintText;
  final TextEditingController controller;
  final TextInputFormatter? keyboardFormat;
  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.label,
    required this.controller,
    this.keyboardFormat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          TextField(
            controller: controller,
            inputFormatters: keyboardFormat != null
                ? [
                    keyboardFormat!
                  ]
                : [],
            decoration: InputDecoration(
              hintText: hintText,
              border: const OutlineInputBorder(borderSide: BorderSide(color: kIconBackgroundColor)),
              enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: kIconBackgroundColor)),
              focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: kIconBackgroundColor)),
            ),
          ),
        ],
      ),
    );
  }
}
