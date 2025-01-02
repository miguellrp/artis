import 'package:artis/src/layouts/general_layout.dart';
import 'package:artis/src/ui_widgets/ui_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static String route = "/home";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralLayout(content: Column(children: [
      Text("HOME PAGE"),
      UICard(widgets: [
        Text("Testeando")
      ],)
    ]));
  }
}