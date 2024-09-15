import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/src/core/utils/validators/validator.dart';
import 'package:task/src/core/utils/widgets/custom_elevated_button.dart';
import 'package:task/src/core/utils/widgets/custom_text_field.dart';
import 'package:task/src/features/home/view_models/tabel_view_model.dart';

import '../../../../../../core/common/widgets/app_text_field.dart';

class UpdateTableView extends StatelessWidget {
  final String tableId;

  const UpdateTableView({super.key, required this.tableId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Table')),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Consumer<TableViewModel>(
            builder: (context, tableViewModel, child) {
              // Pass the tableId to the ViewModel or handle accordingly
              return Column(
                children: [
                  Form(
                    key: tableViewModel.updateTabelFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: tableViewModel.numberOfChairsController,
                          validator: (value) => Validator.validateEmptyText(
                            "Number of chairs",
                            value,
                          ),
                          keyboardType: TextInputType.number,
                          icon: 'assets/images/number.svg',
                          hint: 'Number of chairs',
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: tableViewModel.nameController,
                          validator: (value) => Validator.validateEmptyText(
                            "Name Table",
                            value,
                          ),
                          icon: 'assets/images/name.svg',
                          hint: 'Name Table',
                        ),
                        const SizedBox(height: 20),
                        AppTextField(
                          categories: [
                            SelectedListItem(name: 'Available'),
                            SelectedListItem(name: 'Reserved'),
                          ],
                          textEditingController:
                              tableViewModel.statusController,
                          title: 'Select Status',
                          hint: 'Status',
                          isCategorySelected: true,
                        ),
                        const SizedBox(height: 20),
                        CustomElevatedButton(
                          text: 'Update',
                          onPressed: () {
                            // Call the updateTable method with the passed tableId
                            tableViewModel.updateTable(context, tableId);
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
      ),
    );
  }
}
