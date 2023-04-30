import 'package:flutter/material.dart';
import 'package:miniproject/View/Widgets/my_colors.dart';

class Buttons {
  final MyColors myColors = MyColors();

  ElevatedButton primaryButton(
      {required BuildContext context,
      required void Function() onPressedEvent,
      required IconData icon,
      required String label}) {
    return ElevatedButton.icon(
      onPressed: onPressedEvent,
      icon: Icon(
        icon,
        size: 20,
        color: Colors.white,
      ),
      label: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myColors.primaryColor,
        elevation: 0,
        fixedSize: Size(MediaQuery.of(context).size.width, 70),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  OutlinedButton secondaryButton(
      {required BuildContext context,
      required void Function() onPressedEvent,
      required IconData icon,
      required String label}) {
    return OutlinedButton.icon(
      onPressed: onPressedEvent,
      icon: Icon(
        icon,
        size: 20,
        color: myColors.primaryColor,
      ),
      label: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: myColors.primaryColor,
        ),
      ),
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: 0,
        side: BorderSide(color: myColors.primaryColor, width: 2),
        fixedSize: Size(MediaQuery.of(context).size.width, 70),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  ElevatedButton tertiaryButton(
      {required BuildContext context,
      required void Function() onPressedEvent,
      required IconData icon,
      required String label}) {
    return ElevatedButton.icon(
      onPressed: onPressedEvent,
      icon: Icon(
        icon,
        size: 20,
        color: Colors.white,
      ),
      label: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        elevation: 0,
        fixedSize: Size(MediaQuery.of(context).size.width, 70),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
