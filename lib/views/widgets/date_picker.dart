import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class DatePicker extends StatefulWidget {
  final void Function(DateTime?)? onSelected;
  const DatePicker({
    Key? key,
    this.onSelected,
  }) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  String date = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Pick Event Date",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        GestureDetector(
          onTap: () async {
            final time = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2022),
              lastDate: DateTime(2050),
            );
            widget.onSelected?.call(time);
            setState(() {
              date = time.toString();
            });
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: kIconBackgroundColor),
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            child: Text(
              date.isEmpty ? "Click to pick a date" : date,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
