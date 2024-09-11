import 'package:flutter/material.dart';
import 'package:task/src/features/auth/presentation/views/sign_in/widgets/body_sign_in_view.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BodySignInView(),
    );
  }
}
