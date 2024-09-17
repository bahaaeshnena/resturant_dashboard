import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/src/features/home/presentation/views/home/widgets/cart_invoice_view.dart';
import 'package:task/src/features/home/presentation/views/home/widgets/stream_builder_drop_down_button_tables_selected.dart';
import 'package:task/src/features/home/presentation/views/home/widgets/stream_custom_container_item_invoice.dart';
import 'package:task/src/features/home/view_models/item_view_model.dart';
import 'package:task/src/features/home/view_models/table_view_model.dart';

class CreateAnInvoiceView extends StatelessWidget {
  const CreateAnInvoiceView({super.key, required this.itemViewModel});
  final ItemViewModel itemViewModel;

  @override
  Widget build(BuildContext context) {
    final tableViewModel = Provider.of<TableViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create an invoice'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CartInvoiceView(),
                ),
              );
            },
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(18),
            sliver: SliverToBoxAdapter(
              child: StreamBuilderDropDownButtonTablesSelected(
                  tableViewModel: tableViewModel),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(18),
            sliver: StremCustomContainerItemInvoice(
              itemViewModel: itemViewModel,
            ),
          ),
        ],
      ),
    );
  }
}
