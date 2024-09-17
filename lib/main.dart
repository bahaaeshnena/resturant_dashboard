import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/firebase_options.dart';
import 'package:task/src/core/data/repositories/invoice/invoice_repo.dart';
import 'package:task/src/core/data/repositories/items/items_repo.dart';
import 'package:task/src/core/data/repositories/tables/table_repo.dart';
import 'package:task/src/core/data/repositories/user/user_repo.dart';
import 'package:task/src/features/auth/view_models/auth_view_model.dart';
import 'package:task/src/features/auth/view_models/password_visibility_provider.dart';
import 'package:task/src/features/auth/presentation/views/sign_in/sign_in_view.dart';
import 'package:task/src/features/home/presentation/views/home/home_view.dart';
import 'package:task/src/features/home/view_models/invoice_view_model.dart';
import 'package:task/src/features/home/view_models/item_view_model.dart';
import 'package:task/src/features/home/view_models/selected_table_view_model.dart';
import 'package:task/src/features/home/view_models/table_view_model.dart';

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
          create: (_) => AuthViewModel(userRepository: UserRepository()),
        ),
        ChangeNotifierProvider(
          create: (_) => PasswordVisibilityProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TableViewModel(tableRepo: TableRepo()),
        ),
        ChangeNotifierProvider(
          create: (_) => ItemViewModel(itemRepo: ItemsRepo()),
        ),
        ChangeNotifierProvider(
          create: (_) => InvoiceViewModel(invoiceRepo: InvoiceRepo()),
        ),
        ChangeNotifierProvider(create: (_) => SelectedTableViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: isLoggedIn ? const HomeView() : const SignInView(),
      ),
    );
  }
}
