import 'package:flutter/material.dart';
import 'package:task/src/core/utils/constants/colors.dart';

class BottomSectionSignUp extends StatelessWidget {
  const BottomSectionSignUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account ?',
          style: TextStyle(color: ColorsApp.primaryColor),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Sign In',
            style: TextStyle(
              color: ColorsApp.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
