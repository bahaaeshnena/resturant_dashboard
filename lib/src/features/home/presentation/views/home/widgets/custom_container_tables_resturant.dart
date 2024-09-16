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
    return Center(
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
    );
  }
}
