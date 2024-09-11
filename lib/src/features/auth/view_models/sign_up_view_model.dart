import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task/src/core/utils/helpers/helper_function.dart';
import 'package:task/src/features/auth/models/user_model.dart';
import 'package:task/src/features/auth/presentation/views/home/home_view.dart';

class SignUpViewModel extends ChangeNotifier {
  SignUpViewModel();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance; // Firestore instance
  // final BuildContext context;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  Future<void> signUp(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      if (!signupFormKey.currentState!.validate()) return;

      if (passwordController.text.trim() !=
          confirmPasswordController.text.trim()) {
        HelperFunction.showAlert(
          context,
          'Password Mismatch',
          'The passwords do not match.',
        );
        return;
      }

      final user = UserModel(
        fullName: fullNameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      // Store user data in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'fullName': user.fullName,
        'email': user.email,
      });

      // ignore: use_build_context_synchronously
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const HomeView(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      HelperFunction.showAlert(
        // ignore: use_build_context_synchronously
        context,
        e.code,
        e.message ?? 'No error message',
      );
    } catch (e) {
      HelperFunction.showAlert(
        // ignore: use_build_context_synchronously
        context,
        'Error',
        'An unexpected error occurred',
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
