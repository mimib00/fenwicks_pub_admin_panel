import 'package:admin_panel/models/order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class OrderDataGrid extends StatelessWidget {
  final List<Order> orders;
  final String title;
  const OrderDataGrid({
    Key? key,
    required this.orders,
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
            const SizedBox(height: 30),
            ConstrainedBox(
              constraints: BoxConstraints.loose(Size(Get.width, Get.height * .5)),
              child: SfDataGrid(
                rowHeight: 70,
                onCellTap: (DataGridCellTapDetails details) {
                  // TODO: show order details.
                  // print(orders[details.rowColumnIndex.rowIndex].toMap());
                },
                source: OrderDataSource(
                  order: orders,
                ),
                columnWidthMode: ColumnWidthMode.fill,
                highlightRowOnHover: false,
                columns: [
                  GridColumn(
                    columnName: "Username",
                    minimumWidth: 90,
                    label: Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Name",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  GridColumn(
                    columnName: "Address",
                    minimumWidth: 90,
                    label: Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Description",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  GridColumn(
                    columnName: "Order Date",
                    minimumWidth: 90,
                    label: Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Order Date",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  GridColumn(
                    columnName: "Total",
                    minimumWidth: 90,
                    label: Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Total",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  GridColumn(
                    columnName: "Payment",
                    minimumWidth: 90,
                    label: Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Payment",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  GridColumn(
                    columnName: "Status",
                    minimumWidth: 90,
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
                    columnName: "Products",
                    minimumWidth: 90,
                    label: Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Products",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  // GridColumn(
                  //   columnName: "Actions",
                  //   minimumWidth: 120,
                  //   label: Container(
                  //     padding: const EdgeInsets.all(16.0),
                  //     alignment: Alignment.centerLeft,
                  //     child: const Text(
                  //       "Actions",
                  //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderDataSource extends DataGridSource {
  OrderDataSource({List<Order> order = const []}) {
    orders = order
        .map<DataGridRow>(
          (e) => DataGridRow(
            cells: [
              DataGridCell<String>(columnName: "Username", value: e.owner.name),
              DataGridCell<String>(columnName: "Address", value: e.address),
              DataGridCell<Timestamp>(columnName: "Order Date", value: e.createdAt),
              DataGridCell(columnName: "Total", value: e.total),
              DataGridCell(columnName: "Payment", value: e.method),
              DataGridCell(columnName: "Status", value: e.status),
              DataGridCell(columnName: "Products", value: e.products),
              // DataGridCell<Order>(columnName: "Actions", value: e),
            ],
          ),
        )
        .toList();
  }
  List<DataGridRow> orders = [];

  @override
  List<DataGridRow> get rows => orders;
  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map(
        (dataGridCell) {
          switch (dataGridCell.columnName) {
            case "Order Date":
              var time = DateFormat.yMd().format(dataGridCell.value.toDate());
              return Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  time,
                  style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              );
            case "Total":
              return Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "\$${dataGridCell.value}",
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
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
