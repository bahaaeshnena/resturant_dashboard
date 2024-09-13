import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/src/features/home/presentation/views/drawer/widgets/list_tile_item.dart';
import 'package:task/src/features/auth/view_models/auth_view_model.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.7,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: [
            const Text(
              "Profile",
              style: TextStyle(fontSize: 20),
            ),
            // Use Consumer to get the userName and userEmail
            ListTileItem(
              title: 'User',
              subTitle: 'Email',
              icon: "assets/images/user.svg",
              onTap: () {},
            ),
            const Divider(),
            ListTileItem(
              title: 'Reservation system',
              subTitle: 'To reserve tables and seats',
              icon: "assets/images/category-2.svg",
              onTap: () {},
            ),
            const SizedBox(height: 10),
            ListTileItem(
              title: 'Create an invoice',
              subTitle: 'Create order invoices for customers',
              icon: "assets/images/moneys.svg",
              onTap: () {},
            ),
            const Expanded(child: SizedBox()),
            Consumer<AuthViewModel>(
              builder: (context, authViewModel, child) {
                return ListTileItem(
                  title: 'Logout',
                  subTitle: 'To log out of the session',
                  icon: "assets/images/logout.svg",
                  onTap: () async {
                    await authViewModel.signOut(context);
                  },
                );
              },
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
