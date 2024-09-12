import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/src/features/auth/view_models/sign_in_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignInViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: Column(
          children: [
            Consumer<SignInViewModel>(
              builder: (context, value, child) {
                return GestureDetector(
                  onTap: () {
                    value.logout(context);
                  },
                  child: Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.red,
                      child: const Text('Logout'),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
