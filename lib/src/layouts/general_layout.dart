import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class GeneralLayout extends StatefulWidget {
  final Widget content;
  const GeneralLayout({super.key, required this.content});

  @override
  State<GeneralLayout> createState() => _GeneralPageLayoutState();
}

class _GeneralPageLayoutState extends State<GeneralLayout> with WindowListener {
  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.content,
    );
  }
}
