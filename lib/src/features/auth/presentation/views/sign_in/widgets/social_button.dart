import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/src/core/utils/constants/colors.dart';
import 'package:task/src/features/auth/presentation/views/sign_up/sign_up_view.dart';
import 'package:task/src/features/auth/view_models/auth_view_model.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Or Sign in With '),
          const SizedBox(height: 30),
          Consumer<AuthViewModel>(
            builder: (context, value, child) {
              return GestureDetector(
                onTap: () {
                  value.signInWithGoogle(context);
                },
                child: Card(
                  elevation: 7,
                  color: Colors.white,
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Image.asset('assets/images/Icon-google.png'),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Don\'t have an account ?',
                style: TextStyle(color: ColorsApp.primaryColor),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const SignUpView();
                  }));
                },
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: ColorsApp.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
