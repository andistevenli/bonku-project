import 'package:flutter/material.dart';
import 'package:miniproject/View/Widgets/my_colors.dart';

class SnackBars {
  final MyColors myColors = MyColors();

  SnackBar successSnackBar({required String content, required String label}) {
    return SnackBar(
      backgroundColor: myColors.tertiaryButtonColor,
      behavior: SnackBarBehavior.floating,
      content: Text(
        content,
        style: const TextStyle(color: Colors.black),
      ),
      action: SnackBarAction(
        label: label,
        onPressed: () {
          ScaffoldMessengerState().hideCurrentSnackBar();
        },
        textColor: Colors.black,
      ),
    );
  }

  SnackBar cancelSnackBar({required String content, required String label}) {
    return SnackBar(
      backgroundColor: myColors.detailTextColor,
      behavior: SnackBarBehavior.floating,
      content: Text(content),
      action: SnackBarAction(
        label: label,
        onPressed: () {
          ScaffoldMessengerState().hideCurrentSnackBar();
        },
        textColor: Colors.white,
      ),
    );
  }
}
