import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/src/core/data/repositories/user/user_repo.dart';
import 'package:task/src/core/utils/helpers/helper_function.dart';
import 'package:task/src/features/auth/models/user_model.dart';
import 'package:task/src/features/auth/presentation/views/sign_in/sign_in_view.dart';
import 'package:task/src/features/home/presentation/views/home_view.dart';

class AuthViewModel with ChangeNotifier {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final UserRepository _userRepository;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool _isLoading = false;
  String? _errorMessage;

  AuthViewModel({required UserRepository userRepository})
      : _userRepository = userRepository;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> signinFormKey = GlobalKey<FormState>();

  Future<void> signUp(
      String email, String password, BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
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

      final String fullName = fullNameController.text.trim();

      final UserModel? newUser = await _userRepository
          .signUpWithEmailAndPassword(email, password, fullName);

      if (newUser != null) {
        await _userRepository.saveUserToFirestore(newUser);
        await _userRepository.saveUserLocally(newUser);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);

        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeView(),
          ),
        );
      } else {
        _errorMessage = 'Failed to sign up';
      }
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> signIn(
      String email, String password, BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      if (!signinFormKey.currentState!.validate()) return;

      final UserModel? user =
          await _userRepository.logInWithEmailAndPassword(email, password);

      if (user != null) {
        await _userRepository.saveUserLocally(user);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);

        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeView(),
          ),
        );
      } else {
        _errorMessage = 'Failed to sign in';
      }
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> signOut(BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
      await _userRepository.clearUserLocally();

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', false);

      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const SignInView(),
        ),
      );
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
