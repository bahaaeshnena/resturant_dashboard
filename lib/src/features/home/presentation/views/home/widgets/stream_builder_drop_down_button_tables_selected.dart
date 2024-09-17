import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/src/core/utils/constants/colors.dart';
import 'package:task/src/features/home/models/table_model.dart';
import 'package:task/src/features/home/presentation/views/home/widgets/custom_drop_down_button.dart';
import 'package:task/src/features/home/view_models/selected_table_view_model.dart';
import 'package:task/src/features/home/view_models/table_view_model.dart';

class StreamBuilderDropDownButtonTablesSelected extends StatelessWidget {
  const StreamBuilderDropDownButtonTablesSelected({
    super.key,
    required this.tableViewModel,
  });

  final TableViewModel tableViewModel;

  @override
  Widget build(BuildContext context) {
    final selectedTableProvider = Provider.of<SelectedTableViewModel>(context);

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

        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: ColorsApp.secondaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CustomDropDownButton(
                tableViewModel: tableViewModel,
                reservedTables: reservedTables,
                onTableSelected: (table) {
                  selectedTableProvider.selectTable(table);
                },
              ),
            ),
            const SizedBox(height: 10),
            Text(
              selectedTableProvider.selectedTable != null
                  ? 'Selected table: ${selectedTableProvider.selectedTable?.name}'
                  : 'No table selected',
              style: const TextStyle(
                  color: ColorsApp.primaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 16),
            ),
          ],
        );
      },
    );
  }
}
