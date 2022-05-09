import 'package:admin_panel/utils/constants.dart';
import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function(int)? onTap;
  final int index;
  final int currentIndex;
  const NavigationButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.index,
    required this.currentIndex,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selected = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap?.call(index),
      behavior: HitTestBehavior.opaque,
      child: Card(
        color: selected ? Colors.white : kBackgroundColor,
        elevation: selected ? 3 : 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          leading: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: selected ? kSelectedIconBackgroundColor : kIconBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 30,
              color: Colors.white,
            ),
          ),
          title: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
