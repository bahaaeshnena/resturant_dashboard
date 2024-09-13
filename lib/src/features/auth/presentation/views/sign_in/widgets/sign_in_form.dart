import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/src/features/auth/view_models/password_visibility_provider.dart';
import 'package:task/src/features/auth/view_models/auth_view_model.dart';
import 'package:task/src/core/utils/widgets/custom_elevated_button.dart';
import 'package:task/src/core/utils/widgets/custom_text_field.dart';
import 'package:task/src/core/utils/constants/colors.dart';
import 'package:task/src/core/utils/validators/validator.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer2<PasswordVisibilityProvider, AuthViewModel>(
      builder: (context, passwordVisibilityProvider, viewModelAuth, child) {
        return Form(
          key: viewModelAuth.signinFormKey,
          child: Column(
            children: [
              CustomTextField(
                validator: (value) => Validator.validateEmail(value),
                controller: viewModelAuth.emailController,
                icon: 'assets/images/user.svg',
                hint: 'Email or User Name',
              ),
              const SizedBox(height: 35),
              CustomTextField(
                validator: (value) => Validator.validatePassword(value),
                controller: viewModelAuth.passwordController,
                obscureText: !passwordVisibilityProvider.isPasswordVisible,
                suffixIcon: passwordVisibilityProvider.isPasswordVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                onPressed: () {
                  passwordVisibilityProvider.togglePasswordVisibility();
                },
                icon: 'assets/images/lock.svg',
                hint: 'Password',
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot Password ?',
                      style: TextStyle(
                          color: ColorsApp.primaryColor,
                          fontWeight: FontWeight.w900,
                          fontSize: 15),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              viewModelAuth.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomElevatedButton(
                      onPressed: () async {
                        await viewModelAuth.signIn(
                          viewModelAuth.emailController.text.trim(),
                          viewModelAuth.passwordController.text.trim(),
                          context,
                        );
                      },
                      text: "Sign In",
                    ),
            ],
          ),
        );
      },
    );
  }
}
