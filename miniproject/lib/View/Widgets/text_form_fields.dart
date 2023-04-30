import 'package:flutter/material.dart';
import 'package:miniproject/View/Widgets/my_colors.dart';

class TextFormFields {
  final MyColors myColors = MyColors();

  TextFormField textFormField({
    required bool enabled,
    required TextEditingController textEditingController,
    required TextInputType textInputType,
    required TextCapitalization textCapitalization,
    required String helperText,
    required String hintText,
    required String labelText,
    required IconData icon,
    required String? Function(String?)? validator,
  }) {
    return TextFormField(
      enabled: enabled,
      controller: textEditingController,
      keyboardType: textInputType,
      textCapitalization: textCapitalization,
      autocorrect: false,
      enableSuggestions: false,
      decoration: InputDecoration(
        helperText: helperText,
        hintText: hintText,
        prefixIcon: Icon(icon),
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      validator: validator,
    );
  }
}
