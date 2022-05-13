import 'package:admin_panel/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../controllers/product_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/stock_card.dart';

class ProductDataGrid extends StatefulWidget {
  final String title;
  final List<Product> products;
  const ProductDataGrid({
    Key? key,
    required this.products,
    this.title = "",
  }) : super(key: key);

  @override
  State<ProductDataGrid> createState() => _ProductDataGridState();
}

class _ProductDataGridState extends State<ProductDataGrid> with TickerProviderStateMixin {
  // Products
  final TextEditingController name = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController qty = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController category = TextEditingController();
  final TextEditingController sku = TextEditingController();
  final TextEditingController level = TextEditingController();
  final TextEditingController servings = TextEditingController();

  late TabController controller;

  @override
  void initState() {
    controller = TabController(length: 2, vsync: this, initialIndex: 0);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 20,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: TabBarView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Colors.black),
                    ),
                    CustomButton(
                      icon: Icons.add_rounded,
                      title: "NEW PRODUCT",
                      onTap: () {
                        /// Show a dialog to make user add new products.
                        controller.animateTo(1);
                      },
                    )
                  ],
                ),
                const SizedBox(height: 30),
                ConstrainedBox(
                  constraints: BoxConstraints.loose(Size(Get.width, Get.height * .5)),
                  child: SfDataGrid(
                    source: ProductDataSource(
                      products: widget.products,
                    ),
                    columnWidthMode: ColumnWidthMode.fill,
                    highlightRowOnHover: false,
                    columns: [
                      GridColumn(
                        columnName: "Product",
                        label: Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Product",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: "Category",
                        label: Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "category",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: "Price",
                        label: Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Price",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: "SKU",
                        label: Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "SKU",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: "Quantity",
                        label: Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Quantity",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: "Status",
                        label: Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Status",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: "Actions",
                        label: Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Actions",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(onPressed: () => controller.animateTo(0), icon: const Icon(Icons.arrow_back_ios_new_rounded)),
                    const Text(
                      "Add a new product",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                CustomTextField(hintText: "Name", label: "Name", controller: name),
                CustomTextField(hintText: "Description", label: "Description", controller: description),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        hintText: "Available Quantity",
                        label: "Available Quantity",
                        controller: qty,
                        keyboardFormat: FilteringTextInputFormatter.digitsOnly,
                      ),
                    ),
                    Expanded(
                      child: CustomTextField(
                        hintText: "Price",
                        label: "Price",
                        controller: price,
                        keyboardFormat: FilteringTextInputFormatter.digitsOnly,
                      ),
                    ),
                    Expanded(
                      child: CustomTextField(
                        hintText: "Servings",
                        label: "Servings",
                        controller: servings,
                        keyboardFormat: FilteringTextInputFormatter.digitsOnly,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        hintText: "Category",
                        label: "Category",
                        controller: category,
                        // keyboardFormat: FilteringTextInputFormatter.digitsOnly,
                      ),
                    ),
                    Expanded(
                      child: CustomTextField(
                        hintText: "SKU",
                        label: "Stock Keeping Unit (SKU)",
                        controller: sku,
                        keyboardFormat: FilteringTextInputFormatter.digitsOnly,
                      ),
                    ),
                    Expanded(
                      child: CustomTextField(
                        hintText: "Level",
                        label: "Level",
                        controller: level,
                        keyboardFormat: FilteringTextInputFormatter.digitsOnly,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  child: const Text("Submit"),
                  onPressed: () async {
                    final ProductController ctrl = Get.put(ProductController());
                    if (name.text.isNotEmpty && qty.text.isNotEmpty && price.text.isNotEmpty && category.text.isNotEmpty && sku.text.isNotEmpty) {
                      Map<String, dynamic> data = {
                        "name": name.text,
                        "description": description.text,
                        "rating": 5,
                        "level": int.parse(level.text),
                        "servings": int.parse(servings.text),
                        "price": double.parse(price.text),
                        "category": category.text,
                        "sku": int.parse(sku.text),
                        "quantity": int.parse(qty.text),
                      };

                      final product = Product.fromJson(data);
                      final status = await ctrl.addProduct(product);
                      if (status) controller.animateTo(0);
                    } else {
                      return;
                    }
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ProductDataSource extends DataGridSource {
  ProductDataSource({List<Product> products = const []}) {
    _products = products
        .map<DataGridRow>(
          (e) => DataGridRow(
            cells: [
              DataGridCell(columnName: "Product", value: e.name),
              DataGridCell(columnName: "Category", value: e.category),
              DataGridCell(columnName: "Price", value: e.price),
              DataGridCell(columnName: "SKU", value: e.sku),
              DataGridCell(columnName: "Quantity", value: e.quantity),
              DataGridCell(columnName: "Status", value: e.quantity > 0),
              const DataGridCell(columnName: "Actions", value: null),
            ],
          ),
        )
        .toList();
  }

  List<DataGridRow> _products = [];

  @override
  List<DataGridRow> get rows => _products;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>(
        (dataGridCell) {
          switch (dataGridCell.columnName) {
            case "Product":
              return Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "${dataGridCell.value}",
                  style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              );
            case "Status":
              return StockCard(inStock: dataGridCell.value);
            case "Price":
              return Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "\$${dataGridCell.value}",
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              );
            case "Actions":
              return Row(
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
                ],
              );
            default:
              return Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  dataGridCell.value.toString(),
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              );
          }
        },
      ).toList(),
    );
  }
}
