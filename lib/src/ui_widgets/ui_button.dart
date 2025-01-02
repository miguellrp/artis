import 'package:flutter/material.dart';

class UIButton extends StatefulWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onPressed;

  const UIButton({required this.text, required this.onPressed, this.icon, super.key});

  @override
  UIButtonState createState() => UIButtonState();
}

class UIButtonState extends State<UIButton> {
  late Color buttonColor;
  late BoxShadow buttonShadow;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    buttonColor = Theme.of(context).colorScheme.primary;
    buttonShadow = BoxShadow(
      color: Colors.black54.withAlpha(60),
      spreadRadius: 1,
      offset: Offset(3, 3)
    );
  }

  void refreshPropertiesButtonOnEnter() {
    setState(() {
      buttonColor = Theme.of(context).colorScheme.secondary;
      buttonShadow = BoxShadow(
        color: Colors.transparent
      );
    });
  }

  void refreshPropertiesButtonOnExit() {
    setState(() {
      buttonColor = Theme.of(context).colorScheme.primary;
      buttonShadow = BoxShadow(
        color: Colors.black54.withAlpha(60),
        spreadRadius: 1,
        offset: Offset(3, 3)
      );
    });
  }

  Text getText() {
    return Text(widget.text, style: TextStyle(fontWeight: FontWeight.bold));
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (enterEvent) => refreshPropertiesButtonOnEnter(),
      onExit: (enterEvent) => refreshPropertiesButtonOnExit(),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          duration: Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: buttonColor,
            boxShadow: [buttonShadow]
          ),
          child: widget.icon != null ? Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 5,
            children: [
              getText(),
              Icon(widget.icon, color: Theme.of(context).colorScheme.onSecondary)
            ],
          ) : getText(),
        ),
      ),
    );
  }
}