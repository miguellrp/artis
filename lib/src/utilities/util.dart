import 'package:flutter/material.dart';

class Util {
  static bool strIsEmpty(String? str) {
    return str == null || str == '';
  }

  static bool isMobileSize(BuildContext context) {
    return MediaQuery.of(context).size.width <= 550;
  }
}