import 'package:admin_panel/models/event.dart';
import 'package:admin_panel/views/widgets/date_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../controllers/event_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/stock_card.dart';

class EventsDataGrid extends StatefulWidget {
  final String title;
  final List<Event> events;
  const EventsDataGrid({
    Key? key,
    required this.events,
    this.title = "",
  }) : super(key: key);

  @override
  State<EventsDataGrid> createState() => _EventsGridState();
}

class _EventsGridState extends State<EventsDataGrid> with TickerProviderStateMixin {
  // Products
  final TextEditingController name = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController points = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController secret = TextEditingController();

  DateTime? time;

  String dropValue = EventTypes.concert.name;

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
                      title: "NEW EVENT",
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
                    source: EventDataSource(
                      events: widget.events,
                    ),
                    columnWidthMode: ColumnWidthMode.fill,
                    highlightRowOnHover: false,
                    columns: [
                      GridColumn(
                        columnName: "Name",
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
                        columnName: "Description",
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
                        columnName: "Date",
                        label: Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Date",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: "Points",
                        label: Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Points",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: "Address",
                        label: Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Address",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: "Type",
                        label: Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Type",
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
                      "Add a new event",
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
                      child: DatePicker(
                        onSelected: (date) {
                          if (date != null) time = date;
                        },
                      ),
                    ),
                    Expanded(
                      child: CustomTextField(
                        hintText: "Points",
                        label: "Points",
                        controller: points,
                        keyboardFormat: FilteringTextInputFormatter.digitsOnly,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        hintText: "Secret Word (to genrate QR codes)",
                        label: "Secret Word",
                        controller: secret,
                      ),
                    ),
                    Expanded(
                      child: CustomTextField(
                        hintText: "Address",
                        label: "Address",
                        controller: address,
                      ),
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        value: dropValue,
                        items: [
                          DropdownMenuItem(
                            value: EventTypes.concert.name,
                            child: Text(
                              EventTypes.concert.name,
                            ),
                          ),
                          DropdownMenuItem(
                            value: EventTypes.dancing.name,
                            child: Text(
                              EventTypes.dancing.name,
                            ),
                          ),
                          DropdownMenuItem(
                            value: EventTypes.drinking.name,
                            child: Text(
                              EventTypes.drinking.name,
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() {
                            dropValue = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  child: const Text("Submit"),
                  onPressed: () async {
                    final EventController ctrl = Get.put(EventController());
                    if (name.text.isNotEmpty && description.text.isNotEmpty && points.text.isNotEmpty && address.text.isNotEmpty && secret.text.isNotEmpty && time != null) {
                      Map<String, dynamic> data = {
                        "name": name.text,
                        "description": description.text,
                        "points": int.parse(points.text),
                        "address": address.text,
                        "date": Timestamp.fromDate(time!),
                        "going": [],
                        "secret": secret.text,
                        "photos": <String>[],
                        "type": dropValue,
                      };

                      final event = Event.fromJson(data);
                      final status = await ctrl.addEvent(event);
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

class EventDataSource extends DataGridSource {
  EventDataSource({List<Event> events = const []}) {
    _events = events
        .map<DataGridRow>(
          (e) => DataGridRow(
            cells: [
              DataGridCell<String>(columnName: "Name", value: e.name),
              DataGridCell<String>(columnName: "Description", value: e.description),
              DataGridCell<Timestamp>(columnName: "Date", value: e.date),
              DataGridCell(columnName: "Points", value: e.points),
              DataGridCell(columnName: "Address", value: e.address),
              DataGridCell(columnName: "Type", value: e.type),
              const DataGridCell(columnName: "Actions", value: null),
            ],
          ),
        )
        .toList();
  }
  List<DataGridRow> _events = [];

  @override
  List<DataGridRow> get rows => _events;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>(
        (dataGridCell) {
          switch (dataGridCell.columnName) {
            case "Name":
              return Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "${dataGridCell.value}",
                  style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              );
            case "Description":
              return Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "${dataGridCell.value}",
                  style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              );
            case "Date":
              var time = DateFormat.yMd().format(dataGridCell.value.toDate());
              return Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "${time}",
                  style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              );
              ;
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
