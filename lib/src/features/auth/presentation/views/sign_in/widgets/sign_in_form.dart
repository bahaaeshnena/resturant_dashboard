import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/src/core/utils/constants/colors.dart';
import 'package:task/src/core/utils/validators/validator.dart';
import 'package:task/src/core/utils/widgets/custom_elevated_button.dart';
import 'package:task/src/core/utils/widgets/custom_text_field.dart';
import 'package:task/src/features/auth/view_models/password_visibility_provider.dart';
import 'package:task/src/features/auth/view_models/sign_in_view_model.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PasswordVisibilityProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SignInViewModel(),
        ),
      ],
      child: Consumer2<PasswordVisibilityProvider, SignInViewModel>(
        builder: (context, passwordVisibilityProvider, viewModelSignIn, child) {
          return Form(
            key: viewModelSignIn.signinFormKey,
            child: Column(
              children: [
                CustomTextField(
                  validator: (value) => Validator.validateEmail(value),
                  controller: viewModelSignIn.emailController,
                  icon: 'assets/images/user.svg',
                  hint: 'Email or User Name',
                ),
                const SizedBox(height: 35),
                CustomTextField(
                  validator: (value) => Validator.validatePassword(value),
                  controller: viewModelSignIn.passwordController,
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
                viewModelSignIn.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : CustomElevatedButton(
                        onPressed: () {
                          viewModelSignIn.signIn(context);
                        },
                        text: "Sign In",
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
