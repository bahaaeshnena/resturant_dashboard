import 'package:flutter/material.dart';
import 'package:task/src/core/utils/widgets/custom_elevated_button.dart';
import 'package:task/src/features/home/presentation/views/home/widgets/header_cart_invoice_view.dart';

class CartInvoiceView extends StatelessWidget {
  const CartInvoiceView({super.key});

  @override
  Widget build(BuildContext context) {
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Item1'),
                  Text(r'20$'),
                  Text('4'),
                  Text(r'100$'),
                ],
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Item1'),
                  Text(r'20$'),
                  Text('4'),
                  Text(r'100$'),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(
                thickness: 4,
                color: Colors.black45,
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Total: ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    r'200$',
                    style: TextStyle(
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
                      onPressed: () {},
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
