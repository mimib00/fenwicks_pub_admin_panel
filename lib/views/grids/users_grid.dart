import 'package:admin_panel/controllers/users_controller.dart';
import 'package:admin_panel/models/user.dart';
import 'package:admin_panel/views/widgets/custom_text_field.dart';
import 'package:admin_panel/views/widgets/order_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class UsersDataGrid extends StatefulWidget {
  final String title;
  final List<Users> users;
  const UsersDataGrid({
    Key? key,
    required this.users,
    this.title = "",
  }) : super(key: key);

  @override
  State<UsersDataGrid> createState() => _UsersDataGridState();
}

class _UsersDataGridState extends State<UsersDataGrid> {
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
            GetBuilder<UsersController>(
              builder: (controller) {
                return CustomTextField(
                  hintText: "Search for users by email",
                  label: "Search",
                  onChange: (value) {
                    controller.query(value);
                  },
                );
              },
            ),
            const SizedBox(height: 30),
            ConstrainedBox(
              constraints: BoxConstraints.loose(Size(Get.width, Get.height * .5)),
              child: SfDataGrid(
                rowHeight: 70,
                onCellTap: (DataGridCellTapDetails details) {
                  // Get.dialog(OrderDetails(order: orders[details.rowColumnIndex.rowIndex - 1]));
                },
                source: UsersDataSource(
                  user: widget.users,
                ),
                columnWidthMode: ColumnWidthMode.fill,
                highlightRowOnHover: false,
                columns: [
                  GridColumn(
                    columnName: "ID",
                    minimumWidth: 90,
                    label: Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "ID",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  GridColumn(
                    columnName: "Name",
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
                    columnName: "Email",
                    minimumWidth: 90,
                    label: Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Email",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  GridColumn(
                    columnName: "Points",
                    minimumWidth: 90,
                    label: Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Points",
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

class UsersDataSource extends DataGridSource {
  UsersDataSource({List<Users> user = const []}) {
    users = user
        .map<DataGridRow>(
          (e) => DataGridRow(
            cells: [
              DataGridCell<String>(columnName: "ID", value: e.id),
              DataGridCell<String>(columnName: "Name", value: e.name),
              DataGridCell<String>(columnName: "Email", value: e.email),
              DataGridCell(columnName: "Points", value: e.points),
            ],
          ),
        )
        .toList();
  }
  List<DataGridRow> users = [];

  @override
  List<DataGridRow> get rows => users;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>(
      (dataGridCell) {
        return Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(16.0),
          child: Text(
            dataGridCell.value.toString(),
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
        );
      },
    ).toList());
  }
}
