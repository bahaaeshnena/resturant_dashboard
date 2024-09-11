import 'package:flutter/material.dart';
import 'package:task/src/features/auth/presentation/views/sign_up/widgets/body_sign_up_view.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BodySignUpView(),
    );
  }
}
