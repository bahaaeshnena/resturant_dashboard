import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/src/core/utils/widgets/custom_elevated_button.dart';
import 'package:task/src/features/home/presentation/views/home/widgets/create_an_invoice_view.dart';
import 'package:task/src/features/home/presentation/views/home/widgets/section_resturant_tables.dart';
import 'package:task/src/features/home/presentation/views/home/widgets/stream_builder_card_invoice_page_view.dart';
import 'package:task/src/features/home/view_models/item_view_model.dart';
import 'package:task/src/features/home/view_models/table_view_model.dart';

class BodyHomeView extends StatelessWidget {
  const BodyHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final tableViewModel = Provider.of<TableViewModel>(context);
    final itemViewModel = Provider.of<ItemViewModel>(context);

    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(top: 18, left: 18, right: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Restaurant Tables',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          sliver: SectionResturantTables(tableViewModel: tableViewModel),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: CustomElevatedButton(
                  text: 'Create an invoice',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CreateAnInvoiceView(
                          itemViewModel: itemViewModel,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Invoices(Unpaid)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                StreamBuilderCardInvoicePageView(),
              ],
            ),
          ),
        ),
        // const SliverToBoxAdapter(
        //   child: SizedBox(
        //     width: double.infinity,
        //     height: 300,
        //     child: Chart(),
        //   ),
        // ),
      ],
    );
  }
}
