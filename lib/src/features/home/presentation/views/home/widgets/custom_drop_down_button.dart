import 'package:flutter/material.dart';
import 'package:task/src/core/utils/constants/colors.dart';
import 'package:task/src/features/home/models/table_model.dart';
import 'package:task/src/features/home/view_models/table_view_model.dart';

class CustomDropDownButton extends StatelessWidget {
  const CustomDropDownButton({
    super.key,
    required this.tableViewModel,
    required this.reservedTables,
    required this.onTableSelected,
  });

  final TableViewModel tableViewModel;
  final List<TableModel> reservedTables;
  final void Function(TableModel) onTableSelected;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<TableModel>(
      hint: const Text('Select Table'),
      items: reservedTables.map((TableModel table) {
        return DropdownMenuItem<TableModel>(
          value: table,
          child: Text(
            table.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        );
      }).toList(),
      onChanged: (selectedTable) {
        if (selectedTable != null) {
          onTableSelected(selectedTable);
        }
      },
      dropdownColor: ColorsApp.secondaryColor,
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.white,
      ),
    );
  }
}
