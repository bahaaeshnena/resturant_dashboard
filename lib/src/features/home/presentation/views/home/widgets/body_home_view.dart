import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/src/features/home/presentation/views/home/widgets/section_resturant_tables.dart';
import 'package:task/src/features/home/view_models/tabel_view_model.dart';

class BodyHomeView extends StatelessWidget {
  const BodyHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final tableViewModel = Provider.of<TableViewModel>(context);

    return Padding(
      padding: const EdgeInsets.all(18),
      child: SectionResturantTables(tableViewModel: tableViewModel),
    );
  }
}
