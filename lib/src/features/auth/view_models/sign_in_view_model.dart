import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task/src/core/utils/helpers/helper_function.dart';
import 'package:task/src/features/auth/models/user_model.dart';
import 'package:task/src/features/auth/presentation/views/home/home_view.dart';

class SignInViewModel extends ChangeNotifier {
  SignInViewModel();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> signinFormKey = GlobalKey<FormState>();

  Future<void> signIn(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      if (!signinFormKey.currentState!.validate()) return;

      final user = UserModel(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // ignore: unused_local_variable
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const HomeView(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      HelperFunction.showAlert(
          // ignore: use_build_context_synchronously
          context,
          e.code,
          e.message ?? 'No error message');
    } catch (e) {
      HelperFunction.showAlert(
          // ignore: use_build_context_synchronously
          context,
          'Error',
          'An unexpected error occurred');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
