import 'package:flutter/material.dart';

class HeaderSignUp extends StatelessWidget {
  const HeaderSignUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        const Text("Back"),
      ],
    );
  }
}
