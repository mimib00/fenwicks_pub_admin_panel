import 'package:admin_panel/controllers/product_controller.dart';
import 'package:admin_panel/models/product.dart';
import 'package:admin_panel/views/widgets/data_grid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          if (snapshot.data == null || snapshot.data!.isEmpty) return Container();
          return DataGrid(
            title: "All Products",
            data: snapshot.data!,
          );
        },
      ),
    );
  }
}
