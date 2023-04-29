import 'package:flutter/material.dart';
import 'package:miniproject/View/Widgets/my_colors.dart';

class StatisticBox {
  MyColors myColors = MyColors();

  Container statsBox(BuildContext context, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(14),
      width: MediaQuery.of(context).size.width,
      height: 150,
      decoration: BoxDecoration(
        color: myColors.primaryColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: myColors.primaryColor,
            blurRadius: 10,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 30,
              color: myColors.statsTextColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
