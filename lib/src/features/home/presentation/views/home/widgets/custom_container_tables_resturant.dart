import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/src/features/home/models/tabel_model.dart';
import 'package:task/src/features/home/view_models/tabel_view_model.dart';

class CustomContainerTablesResturant extends StatelessWidget {
  const CustomContainerTablesResturant({
    super.key,
    required this.table,
  });

  final TableModel table;

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    if (table.status == 'Available') {
      statusColor = Colors.green;
    } else if (table.status == 'Reserved') {
      statusColor = Colors.red;
    } else {
      statusColor = Colors.grey;
    }

    var provider = Provider.of<TableViewModel>(context, listen: false);

    return GestureDetector(
      onLongPress: () async {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Table: ${table.name}'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ID: ${table.id}'),
                  Text(
                    'Number of Chairs: ${table.numberOfChairs}',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  table.status.isEmpty
                      ? Text(
                          'Status: Unknown',
                          style: TextStyle(
                              color: statusColor, fontWeight: FontWeight.w700),
                        )
                      : Text(
                          'Status: ${table.status}',
                          style: TextStyle(
                              color: statusColor, fontWeight: FontWeight.w700),
                        ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'),
                ),
                TextButton(
                  onPressed: () async {
                    if (table.status == 'Available') {
                      await provider.updateStatus(table.id!, 'Reserved');
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Reserve'),
                ),
              ],
            );
          },
        );
      },
      child: Center(
        child: Container(
          width: 70,
          height: 70,
          color: statusColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  table.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
