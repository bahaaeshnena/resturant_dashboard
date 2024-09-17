import 'package:flutter/material.dart';
import 'package:task/src/core/utils/constants/colors.dart';
import 'package:task/src/features/home/models/table_model.dart';
import 'package:task/src/features/home/presentation/views/home/widgets/custom_drop_down_button.dart';
import 'package:task/src/features/home/view_models/table_view_model.dart';

class StreamBuilderDropDownButtonTablesSelected extends StatelessWidget {
  const StreamBuilderDropDownButtonTablesSelected({
    super.key,
    required this.tableViewModel,
  });

  final TableViewModel tableViewModel;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TableModel>>(
      stream: tableViewModel.tablesStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No tables available');
        }

        List<TableModel> reservedTables = snapshot.data!
            .where((table) => table.status == "Reserved")
            .toList();

        if (reservedTables.isEmpty) {
          return const Text('No reserved tables available');
        }

        return Container(
          decoration: BoxDecoration(
            color: ColorsApp.secondaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: CustomDropDownButton(
              tableViewModel: tableViewModel, reservedTables: reservedTables),
        );
      },
    );
  }
}
