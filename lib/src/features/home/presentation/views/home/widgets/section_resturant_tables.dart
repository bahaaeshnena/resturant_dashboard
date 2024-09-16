import 'package:flutter/material.dart';
import 'package:task/src/features/home/presentation/views/home/widgets/custom_container_tables_resturant.dart';

import '../../../../models/table_model.dart';
import '../../../../view_models/table_view_model.dart';

class SectionResturantTables extends StatelessWidget {
  const SectionResturantTables({
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
          return const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SliverFillRemaining(
            child: Center(child: Text('No tables available')),
          );
        }

        final tables = snapshot.data!;

        return SliverPadding(
          padding: const EdgeInsets.all(12),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              childAspectRatio: 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final table = tables[index];
                return CustomContainerTablesResturant(table: table);
              },
              childCount: tables.length,
            ),
          ),
        );
      },
    );
  }
}
