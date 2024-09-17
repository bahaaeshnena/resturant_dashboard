// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/src/features/home/presentation/views/home/widgets/header_cart_invoice_view.dart';
import 'package:task/src/features/home/view_models/invoice_view_model.dart';
import 'package:task/src/features/home/view_models/item_view_model.dart';
import 'package:task/src/core/utils/widgets/custom_elevated_button.dart';
import 'package:task/src/features/home/view_models/selected_table_view_model.dart';

class CartInvoiceView extends StatelessWidget {
  const CartInvoiceView({super.key});

  @override
  Widget build(BuildContext context) {
    final itemViewModel = Provider.of<ItemViewModel>(context);
    final invoiceViewModel =
        Provider.of<InvoiceViewModel>(context, listen: false);
    final selectedTableProvider = Provider.of<SelectedTableViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Invoice View'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              const HeaderCartInvoiceView(),
              const Divider(),
              const SizedBox(height: 10),
              ...itemViewModel.selectedItems.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(item.name),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text('${item.price} \$'),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          itemViewModel.removeItemFromCart(item);
                        },
                        child: const Icon(
                          Icons.cancel_outlined,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const Divider(
                thickness: 4,
                color: Colors.black45,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Total: ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    '${itemViewModel.selectedItems.fold(0.0, (total, item) => total + item.price)} \$',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.green),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      text: 'Create an invoice',
                      onPressed: () async {
                        final totalPrice = itemViewModel.selectedItems
                            .fold(0.0, (total, item) => total + item.price);
                        try {
                          final selectedTable =
                              selectedTableProvider.selectedTable;
                          if (selectedTable == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text('No table selected')),
                            );
                          }
                          if (itemViewModel.selectedItems.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text('No Items selected')),
                            );
                          }
                          await invoiceViewModel.createInvoice(
                            selectedTable!,
                            itemViewModel.selectedItems,
                            totalPrice,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor: Colors.green,
                                content: Text('Invoice created successfully')),
                          );
                          itemViewModel.clearCart();
                          selectedTableProvider.clearSelectedTable();
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                backgroundColor: Colors.red,
                                content: Text('Failed to create invoice: $e')),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
