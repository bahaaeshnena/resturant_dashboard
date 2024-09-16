import 'package:flutter/material.dart';
import 'package:task/src/features/home/models/tabel_model.dart';

class ListTileTableItem extends StatelessWidget {
  const ListTileTableItem({
    super.key,
    required this.tableModel,
    this.onTap,
    this.onTapEdit,
    this.onTapDelete,
  });

  final TableModel tableModel;
  final void Function()? onTap;
  final void Function()? onTapEdit;
  final void Function()? onTapDelete;

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    if (tableModel.status == 'Available') {
      statusColor = Colors.green;
    } else if (tableModel.status == 'Reserved') {
      statusColor = Colors.red;
    } else {
      statusColor = Colors.grey;
    }

    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        title: Text(
          tableModel.name,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Number of Chairs: '),
                Text(
                  tableModel.numberOfChairs,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ],
            ),
            Row(
              children: [
                const Text('Status: '),
                Text(
                  tableModel.status,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: statusColor,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: onTapEdit,
              icon: const Icon(
                size: 30,
                Icons.mode_edit_outline,
                color: Colors.blue,
              ),
            ),
            IconButton(
              onPressed: onTapDelete,
              icon: const Icon(
                size: 30,
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
