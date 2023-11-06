import 'package:flutter/material.dart';

class AppErrorView extends StatefulWidget {
  const AppErrorView({super.key});

  @override
  State<AppErrorView> createState() => _AppErrorViewState();
}

class _AppErrorViewState extends State<AppErrorView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AppErrorView")),
    );
  }
}
