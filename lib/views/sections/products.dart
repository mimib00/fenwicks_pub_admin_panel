import 'package:admin_panel/controllers/product_controller.dart';
import 'package:admin_panel/models/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../grids/product_grid.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({Key? key}) : super(key: key);

  final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: FutureBuilder<List<Product>>(
        future: controller.getAllProducts(),
        builder: (context, snapshot) {
          var data = snapshot.data ?? [].cast<Product>().toList();
          return ProductDataGrid(
            title: "All Products",
            products: data,
          );
        },
      ),
    );
  }
}
