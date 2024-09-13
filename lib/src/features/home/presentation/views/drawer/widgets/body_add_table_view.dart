import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/src/core/utils/validators/validator.dart';
import 'package:task/src/core/utils/widgets/custom_elevated_button.dart';
import 'package:task/src/core/utils/widgets/custom_text_field.dart';
import 'package:task/src/features/home/view_models/tabel_view_model.dart';

class BodyAddTableView extends StatelessWidget {
  const BodyAddTableView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Consumer<TableViewModel>(
          builder: (context, tableViewModel, child) {
            return Column(
              children: [
                Form(
                  key: tableViewModel.addTabelFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: tableViewModel.numberOfChairsController,
                        validator: (value) => Validator.volidateEmptyText(
                            "Number of chairs", value),
                        keyboardType: TextInputType.number,
                        icon: 'assets/images/number.svg',
                        hint: 'Number of chairs',
                      ),
                      const SizedBox(height: 20),
                      CustomElevatedButton(
                        text: tableViewModel.isLoading
                            ? 'Adding...'
                            : 'Add table',
                        onPressed: tableViewModel.isLoading
                            ? null
                            : () async {
                                await tableViewModel.addTable();

                                if (tableViewModel.successMessage != null) {
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text(tableViewModel.successMessage!),
                                    ),
                                  );
                                } else if (tableViewModel.errorMessage !=
                                    null) {
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text(tableViewModel.errorMessage!),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
