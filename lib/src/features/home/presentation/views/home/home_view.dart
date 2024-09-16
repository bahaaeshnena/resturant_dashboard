import 'package:flutter/material.dart';
import 'package:task/src/core/utils/constants/colors.dart';
import 'package:task/src/features/home/presentation/views/drawer/custom_drawer.dart';
import 'package:task/src/features/home/presentation/views/home/widgets/body_home_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        drawer: const CustomDrawer(),
        appBar: AppBar(
          backgroundColor: ColorsApp.secondaryColor,
          centerTitle: true,
          title: const Text(
            'Home',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: const BodyHomeView(),
      ),
    );
  }
}
