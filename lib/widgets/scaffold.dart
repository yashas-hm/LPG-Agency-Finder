import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({Key? key, required this.widget, this.actions})
      : super(key: key);
  final Widget widget;
  final Widget? actions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LPG Finder'),
        actions: actions == null ? [] : [actions!],
      ),
      body: widget,
    );
  }
}
