import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/src/core/data/repositories/user/user_repo.dart';
import 'package:task/src/core/utils/constants/colors.dart';
import 'package:task/src/core/utils/validators/validator.dart';
import 'package:task/src/core/utils/widgets/custom_elevated_button.dart';
import 'package:task/src/core/utils/widgets/custom_text_field.dart';
import 'package:task/src/features/auth/view_models/auth_view_model.dart';
import 'package:task/src/features/auth/view_models/password_visibility_provider.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PasswordVisibilityProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthViewModel(userRepository: UserRepository()),
        ),
      ],
      child: Consumer<PasswordVisibilityProvider>(
        builder: (context, passwordVisibilityProvider, child) {
          return Consumer<AuthViewModel>(
            builder: (context, viewModelSignUp, child) {
              return Form(
                key: viewModelSignUp.signupFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
                    const Text(
                      'Sign Up',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: ColorsApp.primaryColor),
                    ),
                    const SizedBox(height: 45),
                    CustomTextField(
                      validator: (value) =>
                          Validator.volidateEmptyText('Full Name', value),
                      controller: viewModelSignUp.fullNameController,
                      icon: 'assets/images/user.svg',
                      hint: 'Full Name',
                    ),
                    const SizedBox(height: 40),
                    CustomTextField(
                      validator: (value) => Validator.validateEmail(value),
                      controller: viewModelSignUp.emailController,
                      icon: 'assets/images/email.svg',
                      hint: 'Email',
                    ),
                    const SizedBox(height: 40),
                    CustomTextField(
                      validator: (value) => Validator.validatePassword(value),
                      controller: viewModelSignUp.passwordController,
                      obscureText:
                          !passwordVisibilityProvider.isPasswordVisible,
                      suffixIcon: passwordVisibilityProvider.isPasswordVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      onPressed: () {
                        passwordVisibilityProvider.togglePasswordVisibility();
                      },
                      icon: 'assets/images/lock.svg',
                      hint: 'Password',
                    ),
                    const SizedBox(height: 40),
                    CustomTextField(
                      validator: (value) => Validator.volidateEmptyText(
                          "Confirm Password", value),
                      controller: viewModelSignUp.confirmPasswordController,
                      obscureText:
                          !passwordVisibilityProvider.isConfirmPasswordVisible,
                      suffixIcon:
                          passwordVisibilityProvider.isConfirmPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                      onPressed: () {
                        passwordVisibilityProvider
                            .toggleConfirmPasswordVisibility();
                      },
                      icon: 'assets/images/lock.svg',
                      hint: 'Confirm Password',
                    ),
                    const SizedBox(height: 60),
                    viewModelSignUp.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomElevatedButton(
                            onPressed: () async {
                              await viewModelSignUp.signUp(
                                viewModelSignUp.emailController.text.trim(),
                                viewModelSignUp.passwordController.text.trim(),
                                context,
                              );
                            },
                            text: "Sign Up",
                          ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
