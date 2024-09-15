import 'package:flutter/material.dart';
import 'package:task/src/features/home/presentation/views/drawer/widgets/body_reservation_system_view.dart';

class ReservationSystemView extends StatelessWidget {
  const ReservationSystemView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservation System'),
      ),
      body: const BodyReservationSystemView(),
    );
  }
}
