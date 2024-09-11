import 'package:flutter/material.dart';
import 'package:task/src/core/utils/constants/colors.dart';

OutlineInputBorder styleTextField() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(18),
    borderSide: const BorderSide(
      width: 2,
      color: ColorsApp.textFieldColor,
    ),
  );
}
