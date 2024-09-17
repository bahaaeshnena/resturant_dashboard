import 'package:flutter/material.dart';
import 'package:task/src/features/home/presentation/views/home/widgets/custom_container_item_invoice.dart';
import 'package:task/src/features/home/view_models/item_view_model.dart';

class StremCustomContainerItemInvoice extends StatelessWidget {
  const StremCustomContainerItemInvoice({
    super.key,
    required this.itemViewModel,
  });

  final ItemViewModel itemViewModel;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: itemViewModel.tablesStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SliverFillRemaining(
            child: Center(child: Text('No items available')),
          );
        }

        final items = snapshot.data!;

        return SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final item = items[index];
              return CustomContainerItemInvoice(
                item: item,
                onTap: () {},
              );
            },
            childCount: items.length,
          ),
        );
      },
    );
  }
}
