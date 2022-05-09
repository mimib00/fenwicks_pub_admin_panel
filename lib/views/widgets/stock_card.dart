import 'package:flutter/material.dart';

class StockCard extends StatelessWidget {
  final bool inStock;
  const StockCard({
    Key? key,
    required this.inStock,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: inStock
              ? [
                  const Color(0xff8be62e),
                  const Color(0xff2bb736),
                ]
              : [
                  const Color(0xfffe6075),
                  const Color(0xffec1012),
                ],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        inStock ? "IN STOCK" : "OUT OF STOCK",
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
      ),
    );
  }
}
