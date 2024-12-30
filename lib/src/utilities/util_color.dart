import 'package:flutter/material.dart';

class UtilColor {
  static Color getDarkWhiteColor(BuildContext context) {
    return Theme.of(context).colorScheme.surface.computeLuminance() > 0.5
        ? Colors.black26
        : Colors.white;
  }
}