import 'package:fast_delivery/src/shared/colors/colors.dart';
import 'package:flutter/material.dart';

class SharedComponents {
  static Widget appBar(String title) {
    return AppBar(
      title: Text(title),
      backgroundColor: AppColors.primaryColor,
    );
  }
}
