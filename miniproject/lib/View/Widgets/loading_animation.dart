import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:miniproject/View/Widgets/my_colors.dart';

class LoadingAnimation {
  MyColors myColors = MyColors();

  Widget staggeredDotsWave() {
    return LoadingAnimationWidget.staggeredDotsWave(
        color: myColors.primaryColor, size: 50);
  }

  Widget stretchedDots() {
    return LoadingAnimationWidget.stretchedDots(
        color: myColors.primaryColor, size: 50);
  }

  Widget fourRotatingDots() {
    return LoadingAnimationWidget.fourRotatingDots(
        color: myColors.primaryColor, size: 50);
  }
}
