import 'package:admin_panel/views/widgets/custom_button.dart';
import 'package:admin_panel/views/widgets/stock_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../models/product.dart';

class DataGrid extends StatelessWidget {
  final String title;
  final List<dynamic> data;
  const DataGrid({
    Key? key,
    required this.data,
    this.title = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 20,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Colors.black),
                ),
                CustomButton(
                  icon: Icons.add_rounded,
                  title: "NEW PRODUCT",
                  onTap: () {},
                )
              ],
            ),
            const SizedBox(height: 30),
            ConstrainedBox(
              constraints: BoxConstraints.loose(Size(Get.width, Get.height * .5)),
              child: SfDataGrid(
                source: ProductDataSource(
                  products: [
                    Product(0, "Beer", "", "Fermented beverages", 1829, 99, 877712, "", true),
                    Product(1, "Brandy", "", "Distilled alcoholic", 1321, 99, 243598234, "", false),
                  ],
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
              DataGridCell(columnName: "Status", value: e.inStock),
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
