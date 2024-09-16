import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/src/core/data/repositories/items/items_repo.dart';
import 'package:task/src/core/utils/widgets/custom_elevated_button.dart';
import 'package:task/src/core/utils/widgets/custom_text_field.dart';
import 'package:task/src/features/home/view_models/item_view_model.dart';

class AddItemsView extends StatelessWidget {
  const AddItemsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ItemViewModel(itemRepo: ItemsRepo()),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Add Item'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(18),
            child: Consumer<ItemViewModel>(
              builder: (context, itemViewModel, child) {
                return Form(
                  key: itemViewModel.addItemFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: itemViewModel.nameItemController,
                        icon: 'assets/images/item.svg',
                        hint: 'name item',
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: itemViewModel.priceController,
                        icon: 'assets/images/price.svg',
                        hint: 'price',
                      ),
                      const SizedBox(height: 20),
                      CustomElevatedButton(
                        text: 'Add Item',
                        onPressed: () {
                          itemViewModel.addTable(context);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
