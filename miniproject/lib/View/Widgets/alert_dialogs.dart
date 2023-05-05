import 'package:flutter/material.dart';
import 'snack_bars.dart';
import 'my_colors.dart';

class AlertDialogs {
  final MyColors myColors = MyColors();
  final SnackBars mySnackBar = SnackBars();

  AlertDialog alertDialog(
      BuildContext context, void Function()? onPressed, String cancelContent) {
    return AlertDialog(
      title: const Text('Konfirmasi'),
      content: const Text('Apakah Anda yakin ?'),
      actions: [
        TextButton(
          onPressed: () {
            if (context.mounted) {
              Navigator.pop(context);
              ScaffoldMessengerState().hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                mySnackBar.cancelSnackBar(
                    content: cancelContent, label: 'Okelah'),
              );
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
