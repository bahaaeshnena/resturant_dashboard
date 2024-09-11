import 'package:flutter/material.dart';
import 'package:task/src/core/utils/constants/colors.dart';

class HelperFunction {
  static void showAlert(BuildContext context, String title, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: ColorsApp.secondaryColor,
            title: Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
            content: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          );
        });
  }
}
