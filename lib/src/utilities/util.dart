import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:flutter/material.dart';

class Util {

  static strIsEmpty(String? str) {
    return str == null || str == '';
  }

  static showWarningMessage(BuildContext context, String message, {String? subtitleMessage, Duration duration = const Duration(seconds: 3)}) {
    DelightToastBar(
      autoDismiss: true,
      snackbarDuration: duration,
      animationDuration: Duration(milliseconds: 400),
      builder: (context) => ToastCard(
        leading: Icon(Icons.warning_rounded, color: Colors.white),
        title: Text(message, style: TextStyle(color: Colors.white)),
        subtitle: !Util.strIsEmpty(subtitleMessage) ? Text(subtitleMessage!) : null,
        color: Colors.orange,
      )
    ).show(context);
  }
}