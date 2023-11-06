import 'package:flutter/material.dart';

class AppLoadingView extends StatefulWidget {
  const AppLoadingView({super.key});

  @override
  State<AppLoadingView> createState() => _AppLoadingViewState();
}

class _AppLoadingViewState extends State<AppLoadingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AppLoadingView")),
    );
  }
}
