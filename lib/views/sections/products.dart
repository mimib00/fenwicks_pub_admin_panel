import 'package:admin_panel/views/widgets/data_grid.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: const DataGrid(
        title: "All Products",
        data: [],
      ),
    );
  }
}
