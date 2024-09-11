import 'package:flutter/material.dart';
import 'package:task/src/features/auth/presentation/views/sign_up/widgets/bottom_section_sign_up.dart';
import 'package:task/src/features/auth/presentation/views/sign_up/widgets/sign_up_form.dart';
import 'package:task/src/features/auth/presentation/views/sign_up/widgets/header_sign_up.dart';

class BodySignUpView extends StatelessWidget {
  const BodySignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: 25, left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              HeaderSignUp(),
              SignUpForm(),
              SizedBox(height: 40),
              BottomSectionSignUp()
            ],
          ),
        ),
      ),
    );
  }
}
