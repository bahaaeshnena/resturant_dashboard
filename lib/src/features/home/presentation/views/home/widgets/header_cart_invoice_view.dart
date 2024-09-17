import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/src/features/home/view_models/selected_table_view_model.dart';

class HeaderCartInvoiceView extends StatelessWidget {
  const HeaderCartInvoiceView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTableProvider = Provider.of<SelectedTableViewModel>(context);

    return Column(
      children: [
        Text(
          'Table name: ${selectedTableProvider.selectedTable?.name ?? 'N/A'}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(height: 20),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Items',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              'Price',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              'Count',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              'Total Price',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
      ],
    );
  }
}
