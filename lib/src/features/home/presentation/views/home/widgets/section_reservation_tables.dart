import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/src/core/common/widgets/app_text_field.dart';
import 'package:task/src/core/utils/widgets/custom_elevated_button.dart';
import 'package:task/src/features/home/view_models/tabel_view_model.dart';

class SectionReservationTables extends StatelessWidget {
  const SectionReservationTables({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<TableViewModel>(
      builder: (context, tableViewModel, child) {
        return SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 18, left: 18, right: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Reservation Tables',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                const SizedBox(height: 10),
                AppTextField(
                  textEditingController:
                      tableViewModel.tablesSelectedController,
                  title: 'Select Table',
                  hint: 'Tables Available',
                  isCategorySelected: true,
                ),
                const SizedBox(height: 10),
                CustomElevatedButton(
                  text: 'Reservation',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
