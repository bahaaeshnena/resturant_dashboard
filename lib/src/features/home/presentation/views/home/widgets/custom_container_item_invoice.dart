import 'package:flutter/material.dart';
import 'package:task/src/core/utils/constants/colors.dart';
import 'package:task/src/features/home/models/item_model.dart';
import 'package:task/src/features/home/view_models/item_view_model.dart';
import 'package:provider/provider.dart';

class CustomContainerItemInvoice extends StatelessWidget {
  const CustomContainerItemInvoice({
    super.key,
    required this.item,
  });
  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    final itemViewModel = Provider.of<ItemViewModel>(context, listen: false);

    return GestureDetector(
      onTap: () {
        itemViewModel.addItemToCart(item);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorsApp.primaryColor,
            width: 4.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  item.name,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '${item.price} \$',
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
