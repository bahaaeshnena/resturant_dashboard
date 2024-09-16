import 'package:flutter/material.dart';
import 'package:task/src/features/home/presentation/views/drawer/widgets/body_resturant_system_view.dart';

class ResturantSystemView extends StatelessWidget {
  const ResturantSystemView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservation System'),
      ),
      body: const BodyResturantSystemView(),
    );
  }
}
