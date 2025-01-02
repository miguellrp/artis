import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';

enum ToastType {
  info,
  warning,
  error,
  success
}

class UIToast {
  UIToast.show(BuildContext context, {ToastType type = ToastType.info, required String message, String? title, Duration duration = const Duration(seconds: 3)}) {
    Text? titleText;
    final Color foregroundColor = Colors.white;
    late Color colorToast;
    late IconData iconToast;

    switch(type) {
      case ToastType.info:
        colorToast = Colors.lightBlue;
        iconToast = Icons.info;
        break;
      case ToastType.warning:
        colorToast = Colors.orange.withAlpha(200);
        iconToast = Icons.warning;
        break;
      case ToastType.error:
        colorToast = Colors.redAccent;
        iconToast = Icons.error;
        break;
      case ToastType.success:
        colorToast = Colors.green;
        iconToast = Icons.check_circle;
        break;
    }

    if (title != null) titleText = Text(title, style: TextStyle(color: colorToast, fontSize: 14, fontWeight: FontWeight.bold));


    ElegantNotification(
      position: Alignment.bottomCenter,
      icon: Icon(iconToast, color: foregroundColor, size: 30),
      title: titleText,
      height: titleText != null ? 150 : 70,
      background: colorToast,
      description: Text(message, style: TextStyle(color: foregroundColor)),
      animation: AnimationType.fromBottom,
      verticalDividerColor: foregroundColor,
      progressBarHeight: 5,
      progressIndicatorColor: colorToast.withAlpha(100),
      toastDuration: duration,
      closeButton: (dismiss) => Align(
        alignment: Alignment.topRight,
        child: IconButton(
          icon: Icon(Icons.close, color: foregroundColor),
          splashColor: null,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: dismiss,
        ),
      ),
    ).show(context);
  }
}