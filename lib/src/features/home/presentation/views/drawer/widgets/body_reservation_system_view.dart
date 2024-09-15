import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/src/core/utils/helpers/helper_function.dart';
import 'package:task/src/features/home/models/tabel_model.dart';
import 'package:task/src/features/home/presentation/views/drawer/widgets/update_table_view.dart';
import 'package:task/src/features/home/view_models/tabel_view_model.dart';
import 'list_tile_table_item.dart';

class BodyReservationSystemView extends StatelessWidget {
  const BodyReservationSystemView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TableViewModel>(
      builder: (context, tableViewModel, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<List<TableModel>>(
            stream: tableViewModel.tablesStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Failed to load tables'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No tables available'));
              } else {
                final tables = snapshot.data!;
                return ListView.builder(
                  itemCount: tables.length,
                  itemBuilder: (context, index) {
                    TableModel table = tables[index];
                    return ListTileTableItem(
                      onTapEdit: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => UpdateTableView(
                              tableId: table.id!,
                            ),
                            settings: RouteSettings(
                              arguments: table, // Pass the selected TableModel
                            ),
                          ),
                        );
                      },
                      onTapDelete: () async {
                        final shouldDelete = await showDialog<bool>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Confirm Delete'),
                              content: const Text(
                                  'Are you sure you want to delete this table?'),
                              actions: [
                                TextButton(
                                  child: const Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                ),
                                TextButton(
                                  child: const Text('Delete'),
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                ),
                              ],
                            );
                          },
                        );

                        if (shouldDelete == true) {
                          await tableViewModel.deleteTable(table.id!);
                        }
                      },
                      tableModel: table,
                      onTap: () {
                        HelperFunction.showAlert(
                          context,
                          table.name,
                          table.id!,
                          table.status,
                          table.numberOfChairs.toString(),
                        );
                      },
                    );
                  },
                );
              }
            },
          ),
        );
      },
    );
  }
}
