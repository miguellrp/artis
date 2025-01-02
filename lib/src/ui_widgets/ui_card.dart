import 'package:flutter/material.dart';

class UICard extends StatelessWidget {
  final List<Widget> widgets;
  final double? verticalSpacing;
  final Color? color;

  const UICard({required this.widgets, this.verticalSpacing = 5, this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color ?? Theme.of(context).colorScheme.onSurface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
      shadowColor: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          spacing: verticalSpacing!,
          mainAxisSize: MainAxisSize.min,
          children: widgets
        )
      ),
    );
  }
}