import 'package:flutter/material.dart';
import 'package:task/src/core/utils/constants/colors.dart';
import 'package:task/src/features/auth/presentation/views/sign_in/widgets/sign_in_form.dart';
import 'package:task/src/features/auth/presentation/views/sign_in/widgets/social_button.dart';

class BodySignInView extends StatelessWidget {
  const BodySignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                width: 200,
                height: 200,
                'assets/images/logo.jpg',
              ),
            ),
            const Text(
              'Sign in',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: ColorsApp.primaryColor),
            ),
            const SizedBox(height: 35),
            const SignInForm(),
            const SizedBox(height: 35),
            const SocialButton()
          ],
        ),
      ),
    );
  }
}
