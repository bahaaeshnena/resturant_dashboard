import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/firebase_options.dart';
import 'package:task/src/features/auth/presentation/views/sign_in/sign_in_view.dart';
import 'package:task/src/features/home/presentation/views/home_view.dart';
import 'package:task/src/features/auth/view_models/sign_in_view_model.dart';
import 'package:task/src/features/auth/view_models/sign_up_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(
    Task(isLoggedIn: isLoggedIn),
  );
}

class Task extends StatelessWidget {
  final bool isLoggedIn;
  const Task({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SignInViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => SignUpViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: isLoggedIn ? const HomeView() : const SignInView(),
      ),
    );
  }
}
