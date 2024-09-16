import 'package:flutter/material.dart';
import 'package:task/src/features/home/models/tabel_model.dart';

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

    return GestureDetector(
      onLongPress: () {
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
                  Text('Number of Chairs: ${table.numberOfChairs}'),
                  table.status == ''
                      ? const Text('Status: Unknown')
                      : Text('Status: ${table.status}'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
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
