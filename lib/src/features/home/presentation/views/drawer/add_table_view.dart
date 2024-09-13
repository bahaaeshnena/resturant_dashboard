import 'package:flutter/material.dart';
import 'package:task/src/features/home/presentation/views/drawer/widgets/body_add_table_view.dart';

class AddTableView extends StatelessWidget {
  const AddTableView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Table'),
        ),
        body: const BodyAddTableView(),
      ),
    );
  }
}
