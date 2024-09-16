import 'package:flutter/material.dart';
import 'package:task/src/features/home/presentation/views/home/widgets/custom_container_tables_resturant.dart';

import '../../../../models/tabel_model.dart';
import '../../../../view_models/tabel_view_model.dart';

class SectionResturantTables extends StatelessWidget {
  const SectionResturantTables({
    super.key,
    required this.tableViewModel,
  });

  final TableViewModel tableViewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Restaurant Tables',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: StreamBuilder<List<TableModel>>(
            stream: tableViewModel.tablesStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No tables available'));
              }

              final tables = snapshot.data!;

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: tables.length,
                itemBuilder: (context, index) {
                  final table = tables[index];
                  return CustomContainerTablesResturant(table: table);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
