import 'package:flutter/material.dart';

import 'my_colors.dart';

class AlertDialogs {
  final MyColors myColors = MyColors();

  AlertDialog alertDialog(BuildContext context, void Function()? onPressed) {
    return AlertDialog(
      title: const Text('Konfirmasi'),
      content: const Text('Apakah Anda yakin ?'),
      actions: [
        TextButton(
          onPressed: () {
            if (context.mounted) {
              Navigator.pop(context);
            }
          },
          child: const Text('Tidak'),
        ),
        TextButton(
          onPressed: onPressed,
          child: const Text('Iya'),
        ),
      ],
    );
  }
}
