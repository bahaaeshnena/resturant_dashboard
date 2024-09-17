import 'package:flutter/material.dart';
import 'package:task/src/core/utils/constants/colors.dart';
import 'package:task/src/features/home/models/table_model.dart';
import 'package:task/src/features/home/view_models/table_view_model.dart';

class CustomDropDownButton extends StatelessWidget {
  const CustomDropDownButton({
    super.key,
    required this.tableViewModel,
    required this.reservedTables,
  });

  final TableViewModel tableViewModel;
  final List<TableModel> reservedTables;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: tableViewModel.selectedTable,
      hint: const Text(
        'Select a reserved table',
        style: TextStyle(color: Colors.white),
      ),
      items: reservedTables.map((TableModel table) {
        return DropdownMenuItem<String>(
          value: table.id,
          child: Text(
            table.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        );
      }).toList(),
      onChanged: (String? value) {
        tableViewModel.setSelectedTable(value);
      },
      dropdownColor: ColorsApp.secondaryColor,
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.white,
      ),
    );
  }
}
