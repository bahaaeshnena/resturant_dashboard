import 'package:flutter/material.dart';
import 'package:task/src/core/utils/widgets/custom_elevated_button.dart';
import 'package:task/src/core/utils/widgets/custom_text_field.dart';

class BodyAddTableView extends StatelessWidget {
  const BodyAddTableView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Form(
              child: Column(
                children: [
                  const CustomTextField(
                    keyboardType: TextInputType.number,
                    icon: 'assets/images/number.svg',
                    hint: 'Number of chairs',
                  ),
                  const SizedBox(height: 20),
                  CustomElevatedButton(
                    text: 'Add table',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
