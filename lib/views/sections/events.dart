import 'package:admin_panel/controllers/event_controller.dart';
import 'package:admin_panel/models/event.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../grids/events_grid.dart';

class EventScreen extends StatelessWidget {
  EventScreen({Key? key}) : super(key: key);

  final EventController controller = Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: FutureBuilder<List<Event>>(
        future: controller.getAllEvents(),
        builder: (context, snapshot) {
          var data = snapshot.data ?? [].cast<Event>().toList();
          return EventsDataGrid(
            title: "All Events",
            events: data,
          );
        },
      ),
    );
  }
}
