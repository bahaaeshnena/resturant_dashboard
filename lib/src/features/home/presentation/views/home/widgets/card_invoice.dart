import 'package:flutter/material.dart';
import 'package:task/src/core/utils/constants/colors.dart';
import 'package:task/src/core/utils/widgets/custom_elevated_button.dart';

class CardInvoice extends StatelessWidget {
  const CardInvoice({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Invoices',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 20),
          AspectRatio(
            aspectRatio: 1 / 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: ColorsApp.secondaryColor.withOpacity(0.5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Row(
                      children: [
                        Text(
                          'Table name : ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'table 1',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      children: [
                        Text(
                          'ID Invoice : ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          '123456788987654321',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      children: [
                        Text(
                          'Date : ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          '09-09-2022',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Items : ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Total Price : ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    CustomElevatedButton(
                      text: 'Pay the bill',
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
