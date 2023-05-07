import 'package:flutter/material.dart';
import 'package:miniproject/View/Widgets/my_colors.dart';

class TextFormFields {
  final MyColors myColors = MyColors();

  SizedBox dateTimeTextFormField({
    required double width,
    required bool enabled,
    required TextEditingController textEditingController,
  }) {
    return SizedBox(
      width: width,
      child: TextFormField(
        enabled: enabled,
        controller: textEditingController,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.calendar_month),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  SizedBox searchTextFormField({
    required double width,
    required bool enabled,
    required TextEditingController textEditingController,
    required String? Function(String?)? validator,
    required void Function(String)? onChangedEvent,
  }) {
    return SizedBox(
      width: width,
      child: TextFormField(
        enabled: enabled,
        controller: textEditingController,
        keyboardType: TextInputType.name,
        textCapitalization: TextCapitalization.words,
        autocorrect: false,
        enableSuggestions: false,
        decoration: InputDecoration(
          errorMaxLines: 2,
          hintText: 'Ketikkan nama',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        validator: validator,
        onChanged: onChangedEvent,
      ),
    );
  }

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
        errorMaxLines: 2,
        helperMaxLines: 2,
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
