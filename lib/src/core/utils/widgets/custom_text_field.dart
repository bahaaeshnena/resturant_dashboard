import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task/src/core/utils/functions/style_text_field.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.icon,
    required this.hint,
    this.suffixIcon,
    this.onPressed,
    this.obscureText = false,
    this.controller,
    this.validator,
  });
  final void Function()? onPressed;
  final String icon;
  final IconData? suffixIcon;
  final String hint;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: SvgPicture.asset(
          icon,
          fit: BoxFit.scaleDown,
        ),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400),
        border: styleTextField(),
        enabledBorder: styleTextField(),
        focusedBorder: styleTextField(),
        suffixIcon: IconButton(
          onPressed: onPressed,
          icon: Icon(suffixIcon),
        ),
      ),
    );
  }
}
